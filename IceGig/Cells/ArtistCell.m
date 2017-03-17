//
//  ArtistCell.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ArtistCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArtistCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(ArtistCellViewModel *)viewModel
{
    _viewModel = viewModel;
    
    [self setupLabels];
    [self setupImageView];
}

- (ArtistCellViewModel *)viewModel
{
    return _viewModel;
}

- (void)setupLabels
{
    self.nameLabel.text = self.viewModel.name;
}

- (void)setupImageView
{
    [self.artistImageView sd_setImageWithURL:self.viewModel.imageURL];
}

@end
