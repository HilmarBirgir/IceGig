//
//  ArtistCellViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ArtistCellViewModel.h"

#import "Artist.h"

NSString *const ARTIST_CELL_REUSE_IDENTIFIER = @"artistCell";

@interface ArtistCellViewModel ()

@property (readwrite, nonatomic, nullable) Artist *artist;
@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;

@end

@implementation ArtistCellViewModel

- (instancetype)initWithArtist:(Artist *)artist
{
    self = [super init];
    
    if (self)
    {
        self.artist = artist;
        self.name = artist.name;
        self.imageURL = artist.imageURL;
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
    return ARTIST_CELL_REUSE_IDENTIFIER;
}

@end
