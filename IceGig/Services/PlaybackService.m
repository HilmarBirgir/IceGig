//
//  PlaybackService.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 13/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "PlaybackService.h"

#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface PlaybackService ()

@property (readwrite, nonatomic) SPTAudioStreamingController *player;

@end

@implementation PlaybackService

- (instancetype)init
{
    return [self initWithPlayer:[SPTAudioStreamingController sharedInstance]];
}

- (instancetype)initWithPlayer:(SPTAudioStreamingController *)player
{
    self = [super init];
    
    if (self)
    {
        self.player = player;
    }
    
    return self;
}

- (RACSignal *)setup
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        self.player.delegate = self;
        NSError *error;
        if ([self.player startWithClientId:CLIENT_ID error:&error])
        {
            [subscriber sendNext:nil];
        }
        else
        {
            [subscriber sendError:error];
        }
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (void)loginWithAccessToken:(NSString *)accessToken
{
    [self.player loginWithAccessToken:accessToken];
}

- (RACSignal *)play:(NSString *)URI
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.player playSpotifyURI:URI startingWithIndex:0 startingWithPosition:0 callback:^(NSError *error) {
            if (error)
            {
                [subscriber sendError:error];
            }
            else
            {
                [subscriber sendNext:nil];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (RACSignal *)stop
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [self.player setIsPlaying:NO callback:^(NSError *error) {
            if (error)
            {
                [subscriber sendError:error];
            }
            else
            {
                [subscriber sendNext:nil];
            }
        }];
        
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

@end
