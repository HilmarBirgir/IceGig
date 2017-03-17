//
//  ArtistCell.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtistCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArtistCell : UITableViewCell

@property (readwrite, nonatomic, nullable) ArtistCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;

@end

NS_ASSUME_NONNULL_END
