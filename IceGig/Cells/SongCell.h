//
//  SongCell.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SongCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SongCell : UITableViewCell

@property (readwrite, nonatomic, nullable) SongCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;

@end

NS_ASSUME_NONNULL_END
