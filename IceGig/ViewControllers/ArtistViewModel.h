//
//  ArtistViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableViewModel.h"

@class NetworkingService;
@class RoutingService;

NS_ASSUME_NONNULL_BEGIN

@interface ArtistViewModel : NSObject<TableViewModel>

- (instancetype)initWithNetworkingService:(NetworkingService *)networkingService
                           routingService:(RoutingService *)routingService;

- (void)downloadArtists;

- (void)didSelectCellAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
