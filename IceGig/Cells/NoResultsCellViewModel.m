//
//  NoResultsCellViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NoResultsCellViewModel.h"

NSString *const NO_RESULTS_CELL_REUSE_IDENTIFIER = @"noResultsCell";

@interface NoResultsCellViewModel ()

@property (readwrite, nonatomic) NSString *message;

@end

@implementation NoResultsCellViewModel

- (instancetype)initWithMessage:(NSString *)message
{
    self = [super init];
    
    if (self)
    {
        self.message = message;
    }
    
    return self;
}

#pragma mark - CellViewModel

- (NSInteger)height
{
    return 80;
}

- (NSString *)reuseIdentifier
{
    return NO_RESULTS_CELL_REUSE_IDENTIFIER;
}

@end
