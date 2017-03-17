//
//  SongCellViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

@class Song;

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const SONG_CELL_REUSE_IDENTIFIER;

@interface SongCellViewModel : NSObject<CellViewModel>

@property (readonly, nonatomic, nullable) Song *song;
@property (readonly, nonatomic, nullable) NSString *name;
@property (readonly, nonatomic, nullable) NSString *artistName;

- (instancetype)initWithSong:(Song *)concert;

@end

NS_ASSUME_NONNULL_END
