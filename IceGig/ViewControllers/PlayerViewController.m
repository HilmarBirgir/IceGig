//
//  PlayerViewController.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "PlayerViewController.h"

#import "UIView+Blur.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlayerViewController ()

@property (readwrite, nonatomic) PlayerViewModel *viewModel;

@end

@implementation PlayerViewController

- (instancetype)initWithViewModel:(PlayerViewModel *)viewModel
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
    
    [self setupLabels];
    [self setupBackgroundView];
    [self setupImageView];
    [self bindObservers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.viewModel play];
}

- (void)setupLabels
{
    self.artistNameLabel.text = self.viewModel.artistName;
    self.songNameLabel.text = self.viewModel.songName;
}

- (void)setupBackgroundView
{
    [self.backgroundView blur];
}

- (void)setupImageView
{
    [self.imageView sd_setImageWithURL:self.viewModel.imageURL];
}

- (void)bindObservers
{
    [RACObserve(self.viewModel, playerState) subscribeNext:^(NSNumber *playerState) {
        PlayerState state = [playerState integerValue];
        
        if(state == PlayerStateStopped)
        {
            self.playButton.hidden = NO;
            self.stopButton.hidden = YES;
            [self.loadingIndicator stopAnimating];
        }
        else if (state == PlayerStatePlaying)
        {
            self.playButton.hidden = YES;
            self.stopButton.hidden = NO;
            [self.loadingIndicator stopAnimating];
        }
        else if (state == PlayerStateLoading)
        {
            self.playButton.hidden = YES;
            self.stopButton.hidden = YES;
            [self.loadingIndicator startAnimating];
        }
    }];
}

- (IBAction)closeButtonPressed:(id)sender
{
    [self.viewModel close];
}

- (IBAction)stopButtonPressed:(id)sender
{
    [self.viewModel stop];
}

- (IBAction)playButtonPressed:(id)sender
{
    [self.viewModel play];
}

- (IBAction)spotifyButtonPressed:(id)sender
{
    [self.viewModel openInSpotify];
}

@end
