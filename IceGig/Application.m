//
//  Application.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Application.h"

#import "Application.h"

#import "RoutingService.h"
#import "NetworkingService.h"
#import "PlaybackService.h"
#import "LoginService.h"
#import "ErrorMessages.h"

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface Application ()

@property (readwrite, nonatomic) RoutingService *routingService;
@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) PlaybackService *playbackService;
@property (readwrite, nonatomic) LoginService *loginService;

@end

@implementation Application

- (instancetype)init
{
    return [self initWithRoutingService:[RoutingService new]
                      networkingService:[NetworkingService new]
                        playbackService:[PlaybackService new]
                           loginService:[LoginService new]];
}

- (instancetype)initWithRoutingService:(RoutingService *)routingService
                     networkingService:(NetworkingService *)networkingService
                       playbackService:(PlaybackService *)playbackService
                          loginService:(LoginService *)loginService
{
    self = [super init];
    
    if (self)
    {
        self.routingService = routingService;
        self.networkingService = networkingService;
        self.playbackService = playbackService;
        self.loginService = loginService;
    }
    
    return self;
}

- (void)setup
{
    [self.routingService setupWindow];

    if ([self.loginService isLoggedIn])
    {
        [self setupLoggedIn];
    }
    else
    {
        [self setupNotLoggedIn];
    }
}

- (void)setupLoggedIn
{
    [self.routingService showTabBarController];
    
    @weakify(self);
    [[self.playbackService setup] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.playbackService loginWithAccessToken:[self.loginService accessToken]];
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        [self.routingService showErrorAlertWithMessage:PLAYBACK_FAILED_TO_SETUP_ERROR];
    }];
}

- (void)setupNotLoggedIn
{
    [self.routingService showLoginViewController];
}

- (nullable UIWindow *)window
{
    return self.routingService.window;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options
{
    if ([self.loginService canHandleURL:url])
    {
        [self.routingService dismissPresentedViewController];
        
        @weakify(self);
        [[self.loginService handleAuthCallbackWithTriggeredAuthURL:url] subscribeNext:^(NSString *accessToken) {
            @strongify(self);
            [self setupLoggedIn];
        } error:^(NSError * _Nullable error) {
            @strongify(self);
            [self.routingService showErrorAlertWithMessage:LOGIN_FAILED_ERROR];
        }];
        
        return YES;
    }
    
    return NO;
}

@end
