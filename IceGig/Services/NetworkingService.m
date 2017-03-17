//
//  NetworkingService.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NetworkingService.h"

#import "APIEndpoints.h"
#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkingService ()

@property (readwrite, nonatomic) AFURLSessionManager *manager;
@property (readwrite, nonatomic) AFHTTPRequestSerializer *serializer;

@end

@implementation NetworkingService

- (instancetype)init
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return [self initWithManager:manager
                      serializer:[AFHTTPRequestSerializer serializer]];
}

- (instancetype)initWithManager:(AFURLSessionManager *)manager
                     serializer:(AFHTTPRequestSerializer *)serializer
{
    self = [super init];
    
    if (self)
    {
        self.manager = manager;
        self.serializer = serializer;
                
        [self setupHeaders];
    }
    
    return self;
}

- (void)setupHeaders
{
    [self.serializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8." forHTTPHeaderField:@"Content-Type"];
    [self.serializer setValue:@"IceGigs" forHTTPHeaderField:@"User-Agent"];
    [self.serializer setValue:@"1.0" forHTTPHeaderField:@"accept-version"];
}

- (RACSignal *)getJsonFromUrl:(NSString *)url
{
    return [self getJsonFromUrl:url parameters:@{}];
}

- (RACSignal *)getJsonFromUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSMutableURLRequest *request = [self.serializer requestWithMethod:@"GET"
                                                                URLString:url                                                               parameters:parameters
                                                                    error:nil];
        
        NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                         completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                             if (error)
                                                             {
                                                                 [subscriber sendError:error];
                                                             }
                                                             else
                                                             {
                                                                 [subscriber sendNext:responseObject];
                                                                 [subscriber sendCompleted];
                                                             }
                                                         }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal *)postToUrl:(NSString *)url
{
    return [self postToUrl:url parameters:@{}];
}

- (RACSignal *)postToUrl:(NSString *)url
               parameters:(NSDictionary *)parameters
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSMutableURLRequest *request = [self.serializer requestWithMethod:@"POST"
                                                                URLString:url
                                                               parameters:parameters
                                                                    error:nil];
        
        NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                         completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                             if (error)
                                                             {
                                                                 [subscriber sendError:error];
                                                             }
                                                             else
                                                             {
                                                                 [subscriber sendNext:responseObject];
                                                                 [subscriber sendCompleted];
                                                             }
                                                         }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

@end
