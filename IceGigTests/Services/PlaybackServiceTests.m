//
//  PlaybackServiceTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "PlaybackService.h"
#import "NSInvocation+Arguments.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface PlaybackServiceTests: UnitTestCase

@property (readwrite, nonatomic) PlaybackService *service;
@property (readwrite, nonatomic) id mockPlayer;

@end

@implementation PlaybackServiceTests

- (void)setUp
{
    [super setUp];
    
    self.mockPlayer = [OCMockObject niceMockForClass:[SPTAudioStreamingController class]];
    self.service = [[PlaybackService alloc] initWithPlayer:self.mockPlayer];
}

- (void)test_setup_sends_next_if_start_with_client_id_does_not_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
        
    [[[self.mockPlayer stub] andReturnValue:OCMOCK_VALUE((BOOL) { YES })] startWithClientId:OCMOCK_ANY error:((NSError __autoreleasing **)[OCMArg anyPointer])];
    
    [[self.service setup] subscribeNext:^(id  _Nullable x) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_setup_sends_error_if_start_with_client_id_errors
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[[self.mockPlayer stub] andReturnValue:OCMOCK_VALUE((BOOL) { NO })] startWithClientId:OCMOCK_ANY error:((NSError __autoreleasing **)[OCMArg anyPointer])];
    
    [[self.service setup] subscribeError:^(NSError *error) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_login_with_access_token_logs_in_with_access_token_on_player
{
    [[self.mockPlayer expect] loginWithAccessToken:@"123"];
    
    [self.service loginWithAccessToken:@"123"];
    
    [self.mockPlayer verify];
}

- (void)test_play_sends_next_if_play_callback_does_not_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSString *uri = @"spotify://123";
    
    [[[self.mockPlayer stub] andDo:^(NSInvocation *invocation) {
        SPTErrorableOperationCallback callback = [invocation argumentAtIndex:3];
        callback(nil);
    }] playSpotifyURI:uri startingWithIndex:0 startingWithPosition:0 callback:OCMOCK_ANY];
    
    [[self.service play:uri] subscribeNext:^(id  _Nullable x) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_play_sends_error_if_play_callback_does_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSString *uri = @"spotify://123";
    
    NSError *error = [NSError new];
    
    [[[self.mockPlayer stub] andDo:^(NSInvocation *invocation) {
        SPTErrorableOperationCallback callback = [invocation argumentAtIndex:3];
        callback(error);
    }] playSpotifyURI:uri startingWithIndex:0 startingWithPosition:0 callback:OCMOCK_ANY];
    
    [[self.service play:uri] subscribeError:^(NSError *signalError) {
        XCTAssertEqual(error, signalError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_stop_sends_next_if_set_is_playing_no_callback_does_not_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[[self.mockPlayer stub] andDo:^(NSInvocation *invocation) {
        SPTErrorableOperationCallback callback = [invocation argumentAtIndex:1];
        callback(nil);
    }] setIsPlaying:NO callback:OCMOCK_ANY];
    
    [[self.service stop] subscribeNext:^(id  _Nullable x) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_stop_sends_error_if_set_is_playing_no_callback_does_error
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSError *error = [NSError new];
    
    [[[self.mockPlayer stub] andDo:^(NSInvocation *invocation) {
        SPTErrorableOperationCallback callback = [invocation argumentAtIndex:1];
        callback(error);
    }] setIsPlaying:NO callback:OCMOCK_ANY];
    
    [[self.service stop] subscribeError:^(NSError *signalError) {
        XCTAssertEqual(error, signalError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
