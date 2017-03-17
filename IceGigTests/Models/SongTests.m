//
//  SongTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "Song.h"

@interface SongTests : UnitTestCase

@end

@implementation SongTests

- (void)test_song_with_nil_data_has_nil_properties_and_does_not_crash
{
    NSDictionary *noData = nil;
    
    Song *song = [[Song alloc] initWithData:noData];
    
    XCTAssertNotNil(song);
    
    XCTAssertNil(song.artistName);
    XCTAssertNil(song.name);
    XCTAssertNil(song.URI);
    XCTAssertNil(song.imageURL);
}

- (void)test_song_with_valid_data_has_correct_properties
{
    NSDictionary *data = [self sampleSongData];
    
    Song *song = [[Song alloc] initWithData:data];

    XCTAssertEqualObjects(song.name, @"Calling your name");
    XCTAssertEqualObjects(song.URI, @"spotify://123");
    XCTAssertEqualObjects(song.artistName, @"Young Thug");
    XCTAssertEqualObjects(song.imageURL, [NSURL URLWithString:@"http://spotify-images.com/young-thug-1"]);
}

@end
