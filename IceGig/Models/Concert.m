//
//  Concert.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Concert.h"

@interface Concert ()

@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSString *venue;
@property (readwrite, nonatomic, nullable) NSDate *date;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;

@end

@implementation Concert

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.name = data[@"eventDateName"];
        self.venue = data[@"eventHallName"];
        self.imageURL = [NSURL URLWithString:data[@"imageSource"]];
        self.date = [self buildDate:data[@"dateOfShow"]];
    }
    
    return self;
}

- (NSDate *)buildDate:(NSString *)dateString
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    return [formatter dateFromString:dateString];
}

@end
