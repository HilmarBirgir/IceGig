//
//  TableViewController.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewModel.h"

@interface TableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic) id<TableViewModel> viewModel;

- (instancetype)initWithViewModel:(id<TableViewModel>)viewModel;

@end
