//
//  ArtistTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "Artist.h"

@interface ArtistTests : UnitTestCase

@end

@implementation ArtistTests

- (void)test_artist_with_nil_data_has_nil_properties_and_does_not_crash
{
    NSDictionary *noData = nil;
    Artist *artist = [[Artist alloc] initWithData:noData];
    
    XCTAssertNotNil(artist);
    
    XCTAssertNil(artist.name);
    XCTAssertNil(artist.ID);
    XCTAssertNil(artist.imageURL);
}

- (void)test_artist_with_valid_data_has_correct_properties
{
    NSDictionary *data = [self sampleArtistData];
    
    Artist *artist = [[Artist alloc] initWithData:data];
    
    XCTAssertEqualObjects(artist.name, @"Young Thug");
    XCTAssertEqualObjects(artist.ID, @"123");
    XCTAssertEqualObjects(artist.imageURL, [NSURL URLWithString:@"http://spotify-images.com/young-thug-2"]);
}

@end
