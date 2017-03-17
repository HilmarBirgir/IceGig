//
//  AppDelegate.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "AppDelegate.h"

#import "Application.h"

@interface AppDelegate ()

@property (readwrite, nonatomic) Application *application;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.application = [Application new];
    [self.application setup];
    
    return YES;
}

- (UIWindow *)window
{
    return [self.application window];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options
{
    return [self.application application:app
                                 openURL:url
                                 options:options];
}

@end
