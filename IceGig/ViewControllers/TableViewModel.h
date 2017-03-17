//
//  TableViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CellViewModel.h"

@protocol TableViewModel <NSObject>

@property (readonly, nonatomic) NSArray<id<CellViewModel>> *cellViewModels;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) BOOL hasPullToRefresh;

@optional

- (void)viewDidLoad;
- (void)didSelectCellAtIndex:(NSInteger)index;
- (void)pullToRefresh;

@end
