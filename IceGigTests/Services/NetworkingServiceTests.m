//
//  NetworkingServiceTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "NetworkingService.h"
#import "NSInvocation+Arguments.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkingServiceTests : UnitTestCase

@property (readwrite, nonatomic) NetworkingService *service;
@property (readwrite, nonatomic) id mockManager;
@property (readwrite, nonatomic) id mockSerializer;

@end

@implementation NetworkingServiceTests

- (void)setUp
{
    [super setUp];
    
    self.mockManager = [OCMockObject niceMockForClass:[AFURLSessionManager class]];
    self.mockSerializer = [OCMockObject niceMockForClass:[AFHTTPRequestSerializer class]];
    
    self.service = [[NetworkingService alloc] initWithManager:self.mockManager
                                                   serializer:self.mockSerializer];
}

- (void)test_service_sends_correct_next_when_get_json_succeeds
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    id mockResponse = [OCMockObject niceMockForClass:[NSURLResponse class]];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = [invocation argumentAtIndex:1];
        block(nil, mockResponse, nil);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service getJsonFromUrl:@"" parameters:@{}] subscribeNext:^(id  _Nullable x) {
        XCTAssertEqual(mockResponse, x);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_error_when_get_json_fails
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSError *error = [NSError errorWithDomain:@"test" code:1 userInfo:@{}];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = [invocation argumentAtIndex:1];
        block(nil, nil, error);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service getJsonFromUrl:@"" parameters:@{}] subscribeError:^(NSError * _Nullable actualError) {
        XCTAssertEqual(error, actualError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_next_when_post_succeeds
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    id mockResponse = [OCMockObject niceMockForClass:[NSURLResponse class]];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = [invocation argumentAtIndex:1];;
        block(nil, mockResponse, nil);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service postToUrl:@"" parameters:@{}] subscribeNext:^(id  _Nullable x) {
        XCTAssertEqual(mockResponse, x);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_error_when_post_fails
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSError *error = [NSError errorWithDomain:@"test" code:1 userInfo:@{}];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = [invocation argumentAtIndex:1];
        block(nil, nil, error);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service postToUrl:@"" parameters:@{}] subscribeError:^(NSError * _Nullable actualError) {
        XCTAssertEqual(error, actualError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
