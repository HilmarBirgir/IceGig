//
//  LoginViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "LoginViewModel.h"

#import "LoginService.h"
#import "RoutingService.h"

@interface LoginViewModelTests : UnitTestCase

@property (readwrite, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.viewModel = [[LoginViewModel alloc] initWithLoginService:self.mockLoginService
                                                   routingService:self.mockRoutingService];
}

- (void)test_start_login_presents_safari_view_controller_on_routing_service_with_auth_url_from_login_service
{
    NSURL *authUrl = [NSURL URLWithString:@"https://spotify.com"];
    
    [[[self.mockLoginService expect] andReturn:authUrl] authenticationURL];
    
    [[self.mockRoutingService expect] presentSafariViewControllerWithURL:authUrl];
    
    [self.viewModel startLogin];
    
    [self.mockLoginService verify];
    
    [self.mockLoginService verify];
}

@end
