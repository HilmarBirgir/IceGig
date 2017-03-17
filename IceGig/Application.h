//
//  Application.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutingService;
@class NetworkingService;
@class LoginService;
@class PlaybackService;
@class UIApplication;
@class UIWindow;

NS_ASSUME_NONNULL_BEGIN

@interface Application : NSObject

@property (readonly, nonatomic) RoutingService *routingService;
@property (readonly, nonatomic) NetworkingService *networkingService;
@property (readonly, nonatomic) LoginService *loginService;
@property (readonly, nonatomic) PlaybackService *playbackService;

- (instancetype)initWithRoutingService:(RoutingService *)routingService
                     networkingService:(NetworkingService *)networkingService
                       playbackService:(PlaybackService *)playbackService
                          loginService:(LoginService *)loginService;

- (void)setup;
- (nullable UIWindow *)window;
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options;

NS_ASSUME_NONNULL_END

@end
