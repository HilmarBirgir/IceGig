//
//  Artist.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Artist.h"

@interface Artist ()

@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSString *ID;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;

@end

@implementation Artist

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.name = data[@"name"];
        self.ID = data[@"id"];
        self.imageURL = [self buildImageURL:data[@"images"]];
    }
    
    return self;
}

- (NSURL *)buildImageURL:(NSArray *)imageURLS
{
    if ([imageURLS count] > 1)
    {
        NSDictionary *imageData = imageURLS[1];
        return [[NSURL alloc] initWithString:imageData[@"url"]];
    }
    
    return nil;
}

@end
