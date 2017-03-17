//
//  ApplicationTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "Application.h"
#import "RoutingService.h"
#import "NetworkingService.h"
#import "PlaybackService.h"
#import "LoginService.h"
#import "ErrorMessages.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ApplicationTests : UnitTestCase

@property (readwrite, nonatomic) Application *application;

@end

@implementation ApplicationTests

- (void)setUp
{
    [super setUp];
    
    self.application = [[Application alloc] initWithRoutingService:self.mockRoutingService
                                                 networkingService:self.mockNetworkingService
                                                   playbackService:self.mockPlaybackService
                                                      loginService:self.mockLoginService];
}

- (void)test_setup_shows_login_view_controller_if_not_logged_in
{
    [[self.mockRoutingService expect] showLoginViewController];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { NO })] isLoggedIn];
    
    [self.application setup];
    
    [self.mockRoutingService verify];
}

- (void)test_setup_shows_tab_bar_controller_if_logged_in
{
    [[self.mockRoutingService expect] showTabBarController];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] isLoggedIn];
    
    [self.application setup];
    
    [self.mockRoutingService verify];
}

- (void)test_failed_setup_of_playback_service_shows_error_on_routing_service
{
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] isLoggedIn];
    
    [[self.mockRoutingService expect] showErrorAlertWithMessage:PLAYBACK_FAILED_TO_SETUP_ERROR];
    
    RACSubject *playbackServiceSetupSignal = [RACSubject subject];
    
    [(PlaybackService *)[[self.mockPlaybackService stub] andReturn:playbackServiceSetupSignal] setup];
    
    [self.application setup];
    
    [playbackServiceSetupSignal sendError:nil];
    
    [self.mockRoutingService verify];
}

- (void)test_application_open_url_returns_no_if_login_service_cannot_handle_url
{
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    
    NSURL *invalidUrl = [NSURL URLWithString:@"dasælkdsa"];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { NO })] canHandleURL:invalidUrl];
    
    XCTAssertFalse([self.application application:mockApplication openURL:invalidUrl options:@{}]);
}

- (void)test_application_open_url_returns_yes_if_login_service_can_handle_url
{
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    
    NSURL *validUrl = [NSURL URLWithString:@"http://spotify.com"];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] canHandleURL:validUrl];
    
    XCTAssertTrue([self.application application:mockApplication openURL:validUrl options:@{}]);
}

- (void)test_returning_from_url_dismisses_presented_view_controller
{
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    
    NSURL *validUrl = [NSURL URLWithString:@"http://spotify.com"];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] canHandleURL:validUrl];

    
    [[self.mockRoutingService expect] dismissPresentedViewController];
    
    [self.application application:mockApplication openURL:validUrl options:@{}];
    
    [self.mockRoutingService verify];
}

- (void)test_returning_from_url_logs_in_on_successful_callback_from_handle_auth_url_on_login_service
{
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    
    NSURL *validUrl = [NSURL URLWithString:@"http://spotify.com"];

    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] canHandleURL:validUrl];
    
    // We only show tab bar controller on login
    [[self.mockRoutingService expect] showTabBarController];
    
    RACSubject *handleAuthSignal = [RACSubject subject];
    
    [[[self.mockLoginService stub] andReturn:handleAuthSignal] handleAuthCallbackWithTriggeredAuthURL:validUrl];
    
    [self.application application:mockApplication openURL:validUrl options:@{}];

    [handleAuthSignal sendNext:nil];
    
    [self.mockRoutingService verify];
}

- (void)test_returning_from_url_shows_error_on_routing_service_in_on_failed_callback_from_handle_auth_url_on_login_service
{
    id mockApplication = [OCMockObject niceMockForClass:[UIApplication class]];
    
    NSURL *validUrl = [NSURL URLWithString:@"http://spotify.com"];
    
    [[[self.mockLoginService stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] canHandleURL:validUrl];
    
    [[self.mockRoutingService expect] showErrorAlertWithMessage:LOGIN_FAILED_ERROR];
    
    RACSubject *handleAuthSignal = [RACSubject subject];
    
    [[[self.mockLoginService stub] andReturn:handleAuthSignal] handleAuthCallbackWithTriggeredAuthURL:validUrl];
    
    [self.application application:mockApplication openURL:validUrl options:@{}];
    
    [handleAuthSignal sendError:nil];
    
    [self.mockRoutingService verify];
}

@end
