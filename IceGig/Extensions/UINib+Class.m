//
//  UINib+Class.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UINib+Class.h"

@implementation UINib (Class)

+ (nullable instancetype)nibFromClass:(nonnull Class)nibClass;
{
    return [self nibWithNibName:NSStringFromClass(nibClass) bundle:nil];
}

@end
