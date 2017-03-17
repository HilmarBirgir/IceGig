//
//  ConcertCellViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ConcertCellViewModel.h"

#import "Concert.h"

NSString *const CONCERT_CELL_REUSE_IDENTIFIER = @"concertCell";

@interface ConcertCellViewModel ()

@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSString *venue;
@property (readwrite, nonatomic, nullable) NSString *date;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;

@end

@implementation ConcertCellViewModel

- (instancetype)initWithConcert:(Concert *)concert
{
    self = [super init];
    
    if (self)
    {
        self.name = concert.name;
        self.venue = concert.venue;
        self.date = [self buildDateString:concert.date];
        self.imageURL = concert.imageURL;
    }
    
    return self;
}

- (NSString *)buildDateString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"EEEE': 'MMMM' 'dd', 'yyyy' at 'HH:mm"];
    
    return [dateFormatter stringFromDate:date];
}

#pragma mark - CellViewModel

- (NSInteger)height
{
    return 120;
}

- (NSString *)reuseIdentifier
{
    return CONCERT_CELL_REUSE_IDENTIFIER;
}

@end
