//
//  PlayerViewController.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : UIViewController

@property (readonly, nonatomic) PlayerViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (instancetype)initWithViewModel:(PlayerViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
