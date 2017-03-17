//
//  NoResultsCell.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NoResultsCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoResultsCell : UITableViewCell

@property (readwrite, nonatomic) NoResultsCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

NS_ASSUME_NONNULL_END
