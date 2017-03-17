//
//  RoutingService.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIWindow;
@class Artist;
@class Song;

NS_ASSUME_NONNULL_BEGIN

@interface RoutingService : NSObject

@property (readonly, nonatomic, nullable) UIWindow *window;

- (void)setupWindow;
- (void)showLoginViewController;
- (void)showTabBarController;
- (void)showSongViewController:(Artist *)artist;
- (void)presentSafariViewControllerWithURL:(NSURL *)url;
- (void)showPlayerViewController:(Song *)song;
- (void)dismissPresentedViewController;
- (void)showErrorAlertWithMessage:(NSString *)message;
- (void)openDeepLink:(NSURL *)deepLink;

@end

NS_ASSUME_NONNULL_END
