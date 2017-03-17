//
//  Song.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Song.h"

@interface Song ()

@property (readwrite, nonatomic, nullable) NSString *artistName;
@property (readwrite, nonatomic, nullable) NSString *name;
@property (readwrite, nonatomic, nullable) NSString *URI;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;

@end

@implementation Song

- (instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.name = data[@"name"];
        self.URI = data[@"uri"];
        self.artistName = [self buildArtist:data[@"artists"]];
        self.imageURL = [self buildImageURL:data[@"album"]];
    }
    
    return self;
}

- (NSString *)buildArtist:(NSArray *)items
{
    if ([items count] > 0)
    {
        NSDictionary *firstArtist = items[0];
        return firstArtist[@"name"];
    }
    
    return nil;
}

- (NSURL *)buildImageURL:(NSDictionary *)albumData
{
    NSArray *imageURLS = albumData[@"images"];
    
    if ([imageURLS count] > 0)
    {
        NSDictionary *imageData = imageURLS[0];
        return [[NSURL alloc] initWithString:imageData[@"url"]];
    }
    
    return nil;
}

@end
