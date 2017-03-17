//
//  NoResultsCellViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const NO_RESULTS_CELL_REUSE_IDENTIFIER;

@interface NoResultsCellViewModel : NSObject<CellViewModel>

@property (readonly, nonatomic) NSString *message;

- (instancetype)initWithMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
