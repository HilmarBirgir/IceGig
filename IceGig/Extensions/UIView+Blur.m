//
//  UIView+Blur.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UIView+Blur.h"

@implementation UIView (Blur)

- (void)blur
{
    if (UIAccessibilityIsReduceTransparencyEnabled() == NO)
    {
        self.alpha = 1;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:blurEffectView];
    }
    else
    {
        self.alpha = 0.6;
        self.backgroundColor = [UIColor blackColor];
    }
}

@end
