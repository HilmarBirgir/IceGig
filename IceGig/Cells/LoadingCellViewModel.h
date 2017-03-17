//
//  LoadingCellViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const LOADING_CELL_REUSE_IDENTIFIER;

@interface LoadingCellViewModel : NSObject<CellViewModel>

@end

NS_ASSUME_NONNULL_END
