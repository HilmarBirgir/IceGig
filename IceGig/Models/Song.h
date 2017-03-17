//
//  Song.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Song : NSObject

@property (readonly, nonatomic, nullable) NSString *artistName;
@property (readonly, nonatomic, nullable) NSString *name;
@property (readonly, nonatomic, nullable) NSString *URI;
@property (readonly, nonatomic, nullable) NSURL *imageURL;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
