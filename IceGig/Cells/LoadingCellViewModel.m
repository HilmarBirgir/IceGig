//
//  LoadingCellViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoadingCellViewModel.h"

NSString *const LOADING_CELL_REUSE_IDENTIFIER = @"loadingCell";

@implementation LoadingCellViewModel

#pragma mark - CellViewModel

- (NSInteger)height
{
    return 80;
}

- (NSString *)reuseIdentifier
{
    return LOADING_CELL_REUSE_IDENTIFIER;
}

@end
