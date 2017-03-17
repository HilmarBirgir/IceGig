//
//  ConcertCell.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ConcertCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation ConcertCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(ConcertCellViewModel *)viewModel
{
    _viewModel = viewModel;
    
    [self setupLabels];
    [self setupImageView];
}

- (ConcertCellViewModel *)viewModel
{
    return _viewModel;
}

- (void)setupLabels
{
    self.nameLabel.text = self.viewModel.name;
    self.venueLabel.text = self.viewModel.venue;
    self.dateLabel.text = self.viewModel.date;
}

- (void)setupImageView
{
    [self.concertImageView sd_setImageWithURL:self.viewModel.imageURL];
}

@end
