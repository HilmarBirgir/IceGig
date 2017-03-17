//
//  ConcertCellViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

@class Concert;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const CONCERT_CELL_REUSE_IDENTIFIER;

@interface ConcertCellViewModel : NSObject<CellViewModel>

@property (readonly, nonatomic, nullable) NSString *name;
@property (readonly, nonatomic, nullable) NSString *venue;
@property (readonly, nonatomic, nullable) NSString *date;
@property (readonly, nonatomic, nullable) NSURL *imageURL;

- (instancetype)initWithConcert:(Concert *)concert;

@end

NS_ASSUME_NONNULL_END
