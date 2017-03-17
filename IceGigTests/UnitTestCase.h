//
//  UnitTestCase.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@class Artist;
@class Concert;
@class Song;

@interface UnitTestCase : XCTestCase

@property (readwrite, nonatomic) id mockRoutingService;
@property (readwrite, nonatomic) id mockNetworkingService;
@property (readwrite, nonatomic) id mockLoginService;
@property (readwrite, nonatomic) id mockPlaybackService;

- (NSDictionary *)sampleArtistData;
- (NSDictionary *)sampleConcertData;
- (NSDictionary *)sampleSongData;

- (Artist *)sampleArtist;
- (Concert *)sampleConcert;
- (Song *)sampleSong;

@end
