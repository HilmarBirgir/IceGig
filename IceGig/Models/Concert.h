//
//  Concert.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Concert : NSObject

@property (readonly, nonatomic, nullable) NSString *name;
@property (readonly, nonatomic, nullable) NSString *venue;
@property (readonly, nonatomic, nullable) NSDate *date;
@property (readonly, nonatomic, nullable) NSURL *imageURL;

- (instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
