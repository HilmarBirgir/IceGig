//
//  PlayerViewModel.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Song;
@class PlaybackService;
@class RoutingService;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PlayerState) {
    PlayerStateLoading,
    PlayerStatePlaying,
    PlayerStateStopped
};

@interface PlayerViewModel : NSObject

@property (readonly, nonatomic, nullable) NSString *artistName;
@property (readonly, nonatomic, nullable) NSString *songName;
@property (readonly, nonatomic, nullable) NSURL *imageURL;
@property (readonly, nonatomic) PlayerState playerState;

- (instancetype)initWithSong:(Song *)song;

- (instancetype)initWithSong:(Song *)song
             playbackService:(PlaybackService *)playbackService
              routingService:(RoutingService *)routingService;

- (void)play;
- (void)stop;
- (void)close;
- (void)openInSpotify;

@end

NS_ASSUME_NONNULL_END
