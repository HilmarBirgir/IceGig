//
//  Application+Singletons.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Application+Singletons.h"

#import "AppDelegate.h"

@implementation Application (Singletons)

+ (Application *)sharedInstance
{
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    return appDelegate.application;
}

+ (RoutingService *)sharedRoutingService
{
    return [self sharedInstance].routingService;
}

+ (NetworkingService *)sharedNetworkingService
{
    return [self sharedInstance].networkingService;
}

+ (LoginService *)sharedLoginService
{
    return [self sharedInstance].loginService;
}

+ (PlaybackService *)sharedPlaybackService
{
    return [self sharedInstance].playbackService;
}

@end
