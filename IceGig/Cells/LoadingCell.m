//
//  LoadingCell.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(LoadingCellViewModel *)viewModel
{
    _viewModel = viewModel;
    
    [self setupLoadingIndicator];
}

- (LoadingCellViewModel *)viewModel
{
    return _viewModel;
}

- (void)setupLoadingIndicator
{
    [self.loadingIndicator startAnimating];
}

@end

