//
//  LoginService.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpotifyAuthentication/SpotifyAuthentication.h>

@class RACSignal;

@interface LoginService : NSObject

- (instancetype)initWithAuth:(SPTAuth *)auth;

- (BOOL)canHandleURL:(NSURL *)url;
- (BOOL)isLoggedIn;

- (NSString *)accessToken;
- (NSURL *)authenticationURL;
- (RACSignal *)handleAuthCallbackWithTriggeredAuthURL:(NSURL *)url;

@end
