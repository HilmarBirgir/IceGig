//
//  NoResultsCell.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NoResultsCell.h"

@implementation NoResultsCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(NoResultsCellViewModel *)viewModel
{
    _viewModel = viewModel;
    
    [self setupLabels];
}

- (NoResultsCellViewModel *)viewModel
{
    return _viewModel;
}

- (void)setupLabels
{
    self.messageLabel.text = self.viewModel.message;
}

@end
