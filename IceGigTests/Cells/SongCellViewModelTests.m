//
//  SongCellViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "SongCellViewModel.h"

#import "Song.h"

@interface SongCellViewModelTests : UnitTestCase

@property (readwrite, nonatomic) SongCellViewModel *viewModel;
@property (readwrite, nonatomic) Song *song;

@end

@implementation SongCellViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.song = [self sampleSong];
    
    self.viewModel = [[SongCellViewModel alloc] initWithSong:self.song];
}

- (void)test_song_is_correctly_set
{
    XCTAssertEqual(self.viewModel.song, self.song);
}

- (void)test_name_is_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.name, @"Calling your name");
}

- (void)test_artist_name_is_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.artistName, @"Young Thug");
}

@end
