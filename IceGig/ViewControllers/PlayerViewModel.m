//
//  PlayerViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 15/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "PlayerViewModel.h"

#import "Application+Singletons.h"
#import "PlaybackService.h"
#import "RoutingService.h"
#import "Song.h"
#import "ErrorMessages.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface PlayerViewModel ()

@property (readwrite, nonatomic) PlaybackService *playbackService;
@property (readwrite, nonatomic) RoutingService *routingService;

@property (readwrite, nonatomic, nullable) Song *song;
@property (readwrite, nonatomic, nullable) NSString *artistName;
@property (readwrite, nonatomic, nullable) NSString *songName;
@property (readwrite, nonatomic, nullable) NSURL *imageURL;
@property (readwrite, nonatomic) PlayerState playerState;

@end

@implementation PlayerViewModel

- (instancetype)initWithSong:(Song *)song
{
    return [self initWithSong:song
              playbackService:[Application sharedPlaybackService]
               routingService:[Application sharedRoutingService]];
}

- (instancetype)initWithSong:(Song *)song
             playbackService:(PlaybackService *)playbackService
              routingService:(RoutingService *)routingService
{
    self = [super init];
    
    if (self)
    {
        self.playbackService = playbackService;
        self.routingService = routingService;
        self.song = song;
        self.artistName = song.artistName;
        self.songName = song.name;
        self.imageURL = song.imageURL;
    }
    
    return self;
}

- (void)play
{
    self.playerState = PlayerStateLoading;

    @weakify(self);
    [[self.playbackService play:self.song.URI] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.playerState = PlayerStatePlaying;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        self.playerState = PlayerStateStopped;
        [self.routingService showErrorAlertWithMessage:PLAY_FAILED_ERROR];
    }];
}

- (void)stop
{
    @weakify(self);
    [[self.playbackService stop] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.playerState = PlayerStateStopped;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        [self.routingService showErrorAlertWithMessage:STOP_FAILED_ERROR];
    }];
}

- (void)close
{
    [self stop];
    [self.routingService dismissPresentedViewController];
}

- (void)openInSpotify
{
    [self stop];
    [self.routingService openDeepLink:[NSURL URLWithString:self.song.URI]];
}

@end
