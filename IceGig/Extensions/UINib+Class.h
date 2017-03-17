//
//  UINib+Class.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (Class)

+ (nullable instancetype)nibFromClass:(nonnull Class)nibClass;

@end
