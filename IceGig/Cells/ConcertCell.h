//
//  ConcertCell.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConcertCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConcertCell : UITableViewCell

@property (readwrite, nonatomic, nullable) ConcertCellViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *concertImageView;

@end

NS_ASSUME_NONNULL_END
