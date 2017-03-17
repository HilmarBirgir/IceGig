//
//  LoginViewController.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (readonly, nonatomic) LoginViewModel *viewModel;

- (instancetype)initWithViewModel:(LoginViewModel *)viewModel;

@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (weak, nonatomic) IBOutlet UIControl *loginButton;

@end

NS_ASSUME_NONNULL_END
