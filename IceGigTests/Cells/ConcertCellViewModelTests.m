//
//  ConcertCellViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ConcertCellViewModel.h"

@interface ConcertCellViewModelTests : UnitTestCase

@property (readwrite, nonatomic) ConcertCellViewModel *viewModel;

@end

@implementation ConcertCellViewModelTests

- (void)setUp
{
    [super setUp];
    
    // We set GMT for this test so we can verify the date string
    
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    
    Concert *concert = [self sampleConcert];
    
    self.viewModel = [[ConcertCellViewModel alloc] initWithConcert:concert];
}

- (void)tearDown
{
    [super tearDown];
    
    [NSTimeZone resetSystemTimeZone];
}

- (void)test_name_gets_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.name, @"Björgvin Halldórsson");
}

- (void)test_venue_gets_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.venue, @"Græni Hatturinn (Akureyri)");
}

- (void)test_date_gets_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.date, @"Saturday: March 11, 2017 at 22:00");
}

- (void)test_image_url_gets_correctly_set
{
    XCTAssertEqualObjects(self.viewModel.imageURL, [NSURL URLWithString:@"https://d30qys758zh01z.cloudfront.net/images/medium/1.9944.jpg"]);
}

@end
