//
//  LoginService.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoginService.h"

#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginService ()

@property (readwrite, nonatomic) SPTAuth *auth;

@end

@implementation LoginService

- (instancetype)init
{
    return [self initWithAuth:[SPTAuth defaultInstance]];
}

- (instancetype)initWithAuth:(SPTAuth *)auth
{
    self = [super init];
    
    if (self)
    {
        self.auth = auth;
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.auth.clientID = CLIENT_ID;
    self.auth.redirectURL = [NSURL URLWithString:REDIRECT_URL];
    self.auth.sessionUserDefaultsKey = SESSION_KEY;
    self.auth.requestedScopes = @[SPTAuthStreamingScope];
}

- (NSURL *)authenticationURL
{
    return [self.auth spotifyWebAuthenticationURL];
}

- (NSString *)accessToken
{
    return self.auth.session.accessToken;
}

- (BOOL)isLoggedIn
{
    return [self.auth.session isValid];
}

- (BOOL)canHandleURL:(NSURL *)url
{
    return [self.auth canHandleURL:url];
}

- (RACSignal *)handleAuthCallbackWithTriggeredAuthURL:(NSURL *)url
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.auth handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            if (error)
            {
                [subscriber sendError:error];
            }
            else if (session)
            {
                [subscriber sendNext:session.accessToken];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
