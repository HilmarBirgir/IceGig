//
//  LoadingCell.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoadingCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadingCell : UITableViewCell

@property (readwrite, nonatomic, nullable) LoadingCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

NS_ASSUME_NONNULL_END
