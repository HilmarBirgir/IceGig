//
//  ArtistCellViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ArtistCellViewModel.h"

@interface ArtistCellViewModelTests : UnitTestCase

@property (readwrite, nonatomic) ArtistCellViewModel *viewModel;
@property (readwrite, nonatomic) Artist *artist;

@end

@implementation ArtistCellViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.artist = [self sampleArtist];
    self.viewModel = [[ArtistCellViewModel alloc] initWithArtist:self.artist];
}

- (void)test_correctly_sets_artist
{
    XCTAssertEqual(self.viewModel.artist, self.artist);
}

- (void)test_correctly_sets_name
{
    XCTAssertEqualObjects(self.viewModel.name, @"Young Thug");
}

- (void)test_correctly_sets_image_url
{
    XCTAssertEqualObjects(self.viewModel.imageURL, [NSURL URLWithString:@"http://spotify-images.com/young-thug-2"]);
}

@end
