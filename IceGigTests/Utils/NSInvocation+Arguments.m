//
//  NSInvocation+Arguments.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NSInvocation+Arguments.h"

@implementation NSInvocation (Arguments)

- (id)argumentAtIndex:(NSInteger)index
{
    id __unsafe_unretained weakArgument = nil;
    [self getArgument:&weakArgument atIndex:index + 2];
    return weakArgument;
}

@end
