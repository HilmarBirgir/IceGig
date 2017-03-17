//
//  SongViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TableViewModel.h"

@class Artist;
@class NetworkingService;
@class RoutingService;

NS_ASSUME_NONNULL_BEGIN

@interface SongViewModel : NSObject<TableViewModel>

- (instancetype)initWithArtist:(Artist *)artist;

- (instancetype)initWithArtist:(Artist *)artist
             networkingService:(NetworkingService *)networkingService
                routingService:(RoutingService *)routingService;

@end

NS_ASSUME_NONNULL_END
