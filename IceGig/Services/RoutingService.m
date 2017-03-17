//
//  RoutingService.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "RoutingService.h"

#import "TableViewController.h"
#import "LoginViewController.h"
#import "PlayerViewController.h"

#import "ArtistViewModel.h"
#import "ConcertViewModel.h"
#import "SongViewModel.h"
#import "Song.h"
#import "UIColor+Colors.h"
#import "UIFont+Fonts.h"

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@interface RoutingService ()

@property (readwrite, nonatomic, nullable) UINavigationController *navigationController;
@property (readwrite, nonatomic, nullable) UIWindow *window;

@end

@implementation RoutingService

- (void)setupWindow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
}

- (void)showLoginViewController
{
    LoginViewModel *viewModel = [LoginViewModel new];
    LoginViewController *viewController = [[LoginViewController alloc] initWithViewModel:viewModel];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.window.rootViewController = self.navigationController;
}

- (void)showTabBarController
{
    UITabBarController *tabBarController = [self buildTabBarController];
    
    NSDictionary *fontAttributes = @{NSFontAttributeName:[UIFont avenirBook:20]};
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.titleTextAttributes = fontAttributes;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    self.window.rootViewController = self.navigationController;
}

- (UITabBarController *)buildTabBarController
{
    UITabBarItem *upcomingItem = [[UITabBarItem alloc] initWithTitle:@"Upcoming"
                                                               image:[UIImage imageNamed:@"upcoming-icon"]
                                                       selectedImage:nil];
    
    ConcertViewModel *concertViewModel = [ConcertViewModel new];
    TableViewController *concertViewController = [[TableViewController alloc] initWithViewModel:concertViewModel];
    concertViewController.tabBarItem = upcomingItem;
    
    UITabBarItem *listenItem = [[UITabBarItem alloc] initWithTitle:@"Listen"
                                                             image:[UIImage imageNamed:@"listen-icon"]
                                                     selectedImage:nil];
    
    ArtistViewModel *artistViewModel = [ArtistViewModel new];
    TableViewController *artistViewController = [[TableViewController alloc] initWithViewModel:artistViewModel];
    artistViewController.tabBarItem = listenItem;
    
    UITabBarController *tabBarController = [UITabBarController new];
    tabBarController.viewControllers = @[concertViewController, artistViewController];
    tabBarController.tabBar.translucent = YES;
    tabBarController.tabBar.barStyle = UIBarStyleBlack;
    tabBarController.tabBar.tintColor = [UIColor spotifyGreen];
    
    NSDictionary *fontAttributes = @{NSFontAttributeName:[UIFont avenirBook:10]};
    [[UITabBarItem appearance] setTitleTextAttributes:fontAttributes forState:UIControlStateNormal];
    
    return tabBarController;
}

- (void)showSongViewController:(Artist *)artist
{
    SongViewModel *viewModel = [[SongViewModel alloc] initWithArtist:artist];
    TableViewController *viewController = [[TableViewController alloc] initWithViewModel:viewModel];
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

- (void)presentSafariViewControllerWithURL:(NSURL *)url
{
    SFSafariViewController *viewController = [[SFSafariViewController alloc] initWithURL:url];
    
    [self.navigationController presentViewController:viewController animated:YES completion:nil];
}

- (void)showPlayerViewController:(Song *)song
{
    PlayerViewModel *viewModel = [[PlayerViewModel alloc] initWithSong:song];
    PlayerViewController *viewController = [[PlayerViewController alloc] initWithViewModel:viewModel];
    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [self.navigationController presentViewController:viewController
                                            animated:YES
                                          completion:nil];
}

- (void)dismissPresentedViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    
    [alertController addAction:ok];
    
    [self.navigationController presentViewController:alertController
                                            animated:YES
                                          completion:nil];
}

- (void)openDeepLink:(NSURL *)deepLink
{
    [[UIApplication sharedApplication] openURL:deepLink
                                       options:@{}
                             completionHandler:nil];
}

@end
