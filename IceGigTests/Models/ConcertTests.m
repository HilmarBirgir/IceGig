//
//  ConcertTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "Concert.h"

@interface ConcertTests : UnitTestCase

@end

@implementation ConcertTests

- (void)test_concert_with_nil_data_has_nil_properties_and_does_not_crash
{
    NSDictionary *noData = nil;
    
    Concert *concert = [[Concert alloc] initWithData:noData];
    
    XCTAssertNotNil(concert);
    
    XCTAssertNil(concert.name);
    XCTAssertNil(concert.venue);
    XCTAssertNil(concert.date);
    XCTAssertNil(concert.imageURL);
}

- (void)test_concert_with_valid_data_has_correct_properties
{
    NSDictionary *data = [self sampleConcertData];
    
    Concert *concert = [[Concert alloc] initWithData:data];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:11];
    [comps setMonth:3];
    [comps setYear:2017];
    [comps setHour:22];
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comps];

    XCTAssertEqualObjects(concert.name, @"Björgvin Halldórsson");
    XCTAssertEqualObjects(concert.venue, @"Græni Hatturinn (Akureyri)");
    XCTAssertEqualObjects(concert.date, date);
    XCTAssertEqualObjects(concert.imageURL, [NSURL URLWithString:@"https://d30qys758zh01z.cloudfront.net/images/medium/1.9944.jpg"]);
}

@end
