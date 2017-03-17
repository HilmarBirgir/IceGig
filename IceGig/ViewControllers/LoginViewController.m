//
//  LoginViewController.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (readwrite, nonatomic) LoginViewModel *viewModel;

@end

@implementation LoginViewController

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel
{
    self = [super init];
    
    if (self)
    {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLoginButton];
}

- (void)setupLoginButton
{
    self.loginButton.layer.cornerRadius = 5;
}

- (IBAction)loginButtonPressed:(id)sender
{
    [self.viewModel startLogin];
}

@end
