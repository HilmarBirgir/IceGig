//
//  Application+Singletons.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Application.h"

@class RoutingService;
@class NetworkingService;
@class LoginService;
@class PlaybackService;

NS_ASSUME_NONNULL_BEGIN

@interface Application (Singletons)

+ (RoutingService *)sharedRoutingService;
+ (NetworkingService *)sharedNetworkingService;
+ (LoginService *)sharedLoginService;
+ (PlaybackService *)sharedPlaybackService;

@end

NS_ASSUME_NONNULL_END
