//
//  ArtistCellViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

@class Artist;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const ARTIST_CELL_REUSE_IDENTIFIER;

@interface ArtistCellViewModel : NSObject<CellViewModel>

@property (readonly, nonatomic, nullable) Artist *artist;
@property (readonly, nonatomic, nullable) NSString *name;
@property (readonly, nonatomic, nullable) NSURL *imageURL;

- (instancetype)initWithArtist:(Artist *)artist;

@end

NS_ASSUME_NONNULL_END
