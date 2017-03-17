//
//  LoginServiceTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "LoginService.h"

#import "NSInvocation+Arguments.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginServiceTests : UnitTestCase

@property (readwrite, nonatomic) LoginService *service;
@property (readwrite, nonatomic) id mockAuth;
@property (readwrite, nonatomic) id mockSession;

@end

@implementation LoginServiceTests

- (void)setUp
{
    [super setUp];
    
    self.mockSession = [OCMockObject niceMockForClass:[SPTSession class]];
    self.mockAuth = [OCMockObject niceMockForClass:[SPTAuth class]];
    [[[self.mockAuth stub] andReturn:self.mockSession] session];
    
    self.service = [[LoginService alloc] initWithAuth:self.mockAuth];
}

- (void)test_authentication_url_returns_spotify_web_authentication_url_from_auth
{
    NSURL *url = [NSURL URLWithString:@"http://lol.is"];
    
    [[[self.mockAuth expect] andReturn:url] spotifyWebAuthenticationURL];
    
    NSURL *returnedUrl = [self.service authenticationURL];
    
    XCTAssertEqualObjects(returnedUrl, url);
    
    [self.mockAuth verify];
}

- (void)test_access_token_returns_access_token_from_session
{
    NSString *accessToken = @"123";
    
    [[[self.mockSession expect] andReturn:accessToken] accessToken];
    
    NSString *returnedAccessToken = [self.service accessToken];
    
    XCTAssertEqualObjects(accessToken, returnedAccessToken);
    
    [self.mockSession verify];
}

- (void)test_is_logged_in_returns_true_when_session_is_valid
{
    [[[self.mockSession stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] isValid];
    
    XCTAssertTrue([self.service isLoggedIn]);
}

- (void)test_is_logged_in_returns_false_when_session_is_not_valid
{
    [[[self.mockSession stub] andReturnValue:OCMOCK_VALUE((BOOL) { NO })] isValid];
    
    XCTAssertFalse([self.service isLoggedIn]);
}

- (void)test_can_handle_url_returns_yes_when_auth_can_handle_url
{
    NSURL *url = [NSURL URLWithString:@"http://lol.is"];
    
    [[[self.mockAuth stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] canHandleURL:url];
    
    XCTAssertTrue([self.service canHandleURL:url]);
}

- (void)test_can_handle_url_returns_no_when_auth_can_not_handle_url
{
    NSURL *url = [NSURL URLWithString:@"http://lol.is"];
    
    [[[self.mockAuth stub] andReturnValue:OCMOCK_VALUE((BOOL) { NO })] canHandleURL:url];
    
    XCTAssertFalse([self.service canHandleURL:url]);
}

- (void)test_handle_auth_callback_with_triggered_url_sends_access_token_if_auth_block_sends_session
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSURL *url = [NSURL URLWithString:@"http://lol.is"];

    [[[self.mockSession stub] andReturn:@"123"] accessToken];
    
    [[[self.mockAuth stub] andDo:^(NSInvocation *invocation) {
        SPTAuthCallback callback = [invocation argumentAtIndex:1];
        callback(nil, self.mockSession);
    }] handleAuthCallbackWithTriggeredAuthURL:url callback:OCMOCK_ANY];
    
    [[self.service handleAuthCallbackWithTriggeredAuthURL:url] subscribeNext:^(NSString *accessToken) {
        XCTAssertEqualObjects(accessToken, @"123");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_handle_auth_callback_with_triggered_url_sends_error_if_auth_block_sends_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSURL *url = [NSURL URLWithString:@"http://lol.is"];
    NSError *error = [NSError new];
    
    [[[self.mockAuth stub] andDo:^(NSInvocation *invocation) {
        SPTAuthCallback callback = [invocation argumentAtIndex:1];
        callback(error, nil);
    }] handleAuthCallbackWithTriggeredAuthURL:url callback:OCMOCK_ANY];
    
    [[self.service handleAuthCallbackWithTriggeredAuthURL:url] subscribeError:^(NSError *signalError) {
        XCTAssertEqual(error, signalError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
