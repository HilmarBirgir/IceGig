//
//  SongCellViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "SongCellViewModel.h"

#import "Application+Singletons.h"
#import "PlaybackService.h"
#import "Song.h"

NSString *const SONG_CELL_REUSE_IDENTIFIER = @"songCell";

@interface SongCellViewModel ()

@property (readwrite, nonatomic, nullable) Song *song;
@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSString *artistName;

@end

@implementation SongCellViewModel

- (instancetype)initWithSong:(Song *)song
{
    self = [super init];
    
    if (self)
    {
        self.song = song;
        self.name = song.name;
        self.artistName = song.artistName;
    }
    
    return self;
}

#pragma mark - CellViewModel

- (NSInteger)height
{
    return 66;
}

- (NSString *)reuseIdentifier
{
    return SONG_CELL_REUSE_IDENTIFIER;
}
@end
