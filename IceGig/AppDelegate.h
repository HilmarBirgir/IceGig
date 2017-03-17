//
//  AppDelegate.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Application;

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic, nullable) UIWindow *window;
@property (readonly, nonatomic) Application *application;

NS_ASSUME_NONNULL_END

@end

