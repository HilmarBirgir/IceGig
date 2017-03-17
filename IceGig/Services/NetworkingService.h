//
//  NetworkingService.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class AFURLSessionManager;
@class AFHTTPRequestSerializer;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingService : NSObject

- (instancetype)initWithManager:(AFURLSessionManager *)manager
                     serializer:(AFHTTPRequestSerializer *)serializer;

- (RACSignal *)getJsonFromUrl:(NSString *)url;

- (RACSignal *)getJsonFromUrl:(NSString *)url
                   parameters:(NSDictionary *)parameters;

- (RACSignal *)postToUrl:(NSString *)url;

- (RACSignal *)postToUrl:(NSString *)url
              parameters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
