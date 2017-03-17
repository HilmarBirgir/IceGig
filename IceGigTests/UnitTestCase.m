//
//  UnitTestCase.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "NetworkingService.h"
#import "RoutingService.h"
#import "LoginService.h"
#import "PlaybackService.h"
#import "Artist.h"
#import "Concert.h"
#import "Song.h"

@implementation UnitTestCase

- (id)mockRoutingService
{
    if (_mockRoutingService == nil)
    {
        _mockRoutingService = [OCMockObject niceMockForClass:[RoutingService class]];
    }
    
    return _mockRoutingService;
}
- (id)mockNetworkingService
{
    if (_mockNetworkingService == nil)
    {
        _mockNetworkingService = [OCMockObject niceMockForClass:[NetworkingService class]];
    }
    
    return _mockNetworkingService;
}

- (id)mockLoginService
{
    if (_mockLoginService == nil)
    {
        _mockLoginService = [OCMockObject niceMockForClass:[LoginService class]];
    }
    
    return _mockLoginService;
}

- (id)mockPlaybackService
{
    if (_mockPlaybackService == nil)
    {
        _mockPlaybackService = [OCMockObject niceMockForClass:[PlaybackService class]];
    }
    
    return _mockPlaybackService;
}

- (NSDictionary *)sampleArtistData
{
    NSDictionary *data = @{@"name": @"Young Thug",
                           @"id": @"123",
                           @"images": @[@{@"url": @"http://spotify-images.com/young-thug-1"},
                                        @{@"url": @"http://spotify-images.com/young-thug-2"},
                                        @{@"url": @"http://spotify-images.com/young-thug-3"}]};

    return data;
}

- (NSDictionary *)sampleConcertData
{
    NSDictionary *data = @{@"eventDateName": @"Björgvin Halldórsson",
                           @"name": @"Bestu lög Björgvins",
                           @"dateOfShow": @"2017-03-11T22:00:00",
                           @"userGroupName": @"Bitra ehf",
                           @"eventHallName": @"Græni Hatturinn (Akureyri)",
                           @"imageSource": @"https://d30qys758zh01z.cloudfront.net/images/medium/1.9944.jpg"};
    
    return data;
}

- (NSDictionary *)sampleSongData
{
    NSDictionary *data = @{@"name": @"Calling your name",
                           @"uri": @"spotify://123",
                           @"artists": @[@{@"name": @"Young Thug"}],
                           @"album": @{@"images": @[@{@"url": @"http://spotify-images.com/young-thug-1"},
                                                    @{@"url": @"http://spotify-images.com/young-thug-2"},
                                                    @{@"url": @"http://spotify-images.com/young-thug-3"}]}};
    
    return data;
}

- (Artist *)sampleArtist
{
    NSDictionary *data = [self sampleArtistData];
    
    return [[Artist alloc] initWithData:data];
}

- (Concert *)sampleConcert
{
    NSDictionary *data = [self sampleConcertData];

    return [[Concert alloc] initWithData:data];
}

- (Song *)sampleSong
{
    NSDictionary *data = [self sampleSongData];
    
    return [[Song alloc] initWithData:data];
}

@end
