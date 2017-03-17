//
//  LoginViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoginViewModel.h"

#import "LoginService.h"
#import "RoutingService.h"
#import "Application+Singletons.h"

@interface LoginViewModel ()

@property (readwrite, nonatomic) LoginService *loginService;
@property (readwrite, nonatomic) RoutingService *routingService;

@end

@implementation LoginViewModel

- (instancetype)init
{
    return [self initWithLoginService:[Application sharedLoginService]
                       routingService:[Application sharedRoutingService]];
}

- (instancetype)initWithLoginService:(LoginService *)loginService
                      routingService:(RoutingService *)routingService
{
    self = [super init];
    
    if (self)
    {
        self.loginService = loginService;
        self.routingService = routingService;
    }
    
    return self;
}

- (void)startLogin
{
    NSURL *authURL = [self.loginService authenticationURL];
    [self.routingService presentSafariViewControllerWithURL:authURL];
}

@end
