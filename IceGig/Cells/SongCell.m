//
//  SongCell.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "SongCell.h"

@implementation SongCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(SongCellViewModel *)viewModel
{
    _viewModel = viewModel;
    
    [self setupLabels];
}

- (SongCellViewModel *)viewModel
{
    return _viewModel;
}

- (void)setupLabels
{
    self.artistLabel.text = self.viewModel.artistName;
    self.songLabel.text = self.viewModel.name;
}

@end
