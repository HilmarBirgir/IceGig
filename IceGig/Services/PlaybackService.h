//
//  PlaybackService.h
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface PlaybackService : NSObject<SPTAudioStreamingDelegate>

- (instancetype)initWithPlayer:(SPTAudioStreamingController *)player;

- (RACSignal *)setup;
- (void)loginWithAccessToken:(NSString *)accessToken;
- (RACSignal *)play:(NSString *)URI;
- (RACSignal *)stop;

@end

NS_ASSUME_NONNULL_END
