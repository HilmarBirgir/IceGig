//
//  PlayerViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "PlayerViewModel.h"
#import "PlaybackService.h"
#import "RoutingService.h"
#import "Song.h"
#import "ErrorMessages.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface PlayerViewModelTests : UnitTestCase

@property (readwrite, nonatomic) PlayerViewModel *viewModel;

@end

@implementation PlayerViewModelTests

- (void)setUp
{
    [super setUp];
    
    Song *song = [self sampleSong];
    
    self.viewModel = [[PlayerViewModel alloc] initWithSong:song
                                           playbackService:self.mockPlaybackService
                                            routingService:self.mockRoutingService];
}

- (void)test_nil_song_sets_nil_properties
{
    Song *noSong = nil;
    
    PlayerViewModel *viewModel = [[PlayerViewModel alloc] initWithSong:noSong
                                                       playbackService:self.mockPlaybackService
                                                        routingService:self.mockRoutingService];

    XCTAssertNotNil(viewModel);
    
    XCTAssertNil(viewModel.artistName);
    XCTAssertNil(viewModel.songName);
    XCTAssertNil(viewModel.imageURL);
}

- (void)test_valid_song_sets_correct_properties
{
    XCTAssertEqualObjects(self.viewModel.artistName, @"Young Thug");
    XCTAssertEqualObjects(self.viewModel.songName, @"Calling your name");
    XCTAssertEqualObjects(self.viewModel.imageURL, [NSURL URLWithString:@"http://spotify-images.com/young-thug-1"]);
}

- (void)test_play_initally_sets_state_to_loading
{
    [self.viewModel play];
    
    XCTAssertEqual(self.viewModel.playerState, PlayerStateLoading);
}

- (void)test_successful_playing_sets_player_state_to_playing
{
    XCTAssertEqual(self.viewModel.playerState, PlayerStateLoading);
    
    RACSubject *playSignal = [RACSubject subject];
    
    [[[self.mockPlaybackService stub] andReturn:playSignal] play:@"spotify://123"];
    
    [self.viewModel play];

    [playSignal sendNext:nil];
    
    XCTAssertEqual(self.viewModel.playerState, PlayerStatePlaying);
}

- (void)test_failed_playing_sets_player_state_to_stopped
{
    XCTAssertEqual(self.viewModel.playerState, PlayerStateLoading);
    
    RACSubject *playSignal = [RACSubject subject];
    
    [[[self.mockPlaybackService stub] andReturn:playSignal] play:@"spotify://123"];
    
    [self.viewModel play];
    
    [playSignal sendError:nil];
    
    XCTAssertEqual(self.viewModel.playerState, PlayerStateStopped);
}

- (void)test_failed_playing_shows_error_on_router
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:PLAY_FAILED_ERROR];
    
    RACSubject *playSignal = [RACSubject subject];
    
    [[[self.mockPlaybackService stub] andReturn:playSignal] play:@"spotify://123"];
    
    [self.viewModel play];
    
    [playSignal sendError:nil];
    
    [self.mockRoutingService verify];
}

- (void)test_successful_stopping_sets_state_to_stopped
{
    XCTAssertEqual(self.viewModel.playerState, PlayerStateLoading);
    
    RACSubject *playSignal = [RACSubject subject];
    
    [(PlaybackService *)[[self.mockPlaybackService stub] andReturn:playSignal] stop];
    
    [self.viewModel stop];
    
    [playSignal sendNext:nil];
    
    XCTAssertEqual(self.viewModel.playerState, PlayerStateStopped);
}

- (void)test_failed_stopping_shows_error_message_on_router
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:STOP_FAILED_ERROR];
    
    RACSubject *playSignal = [RACSubject subject];
    
    [(PlaybackService *)[[self.mockPlaybackService stub] andReturn:playSignal] stop];
    
    [self.viewModel stop];
    
    [playSignal sendError:nil];
    
    [self.mockRoutingService verify];
}

- (void)test_close_stops_playing
{
    [(PlaybackService *)[self.mockPlaybackService expect] stop];
    
    [self.viewModel close];
    
    [self.mockPlaybackService verify];
}

- (void)test_close_dismisses_presented_view_controller_on_router
{
    [[self.mockRoutingService expect] dismissPresentedViewController];
    
    [self.viewModel close];
    
    [self.mockRoutingService verify];
}

- (void)test_open_in_spotify_stops_playing
{
    [(PlaybackService *)[self.mockPlaybackService expect] stop];
    
    [self.viewModel openInSpotify];
    
    [self.mockPlaybackService verify];
}

- (void)test_open_in_spotify_opens_deep_link_on_router
{
    [[self.mockRoutingService expect] openDeepLink:OCMOCK_ANY];
    
    [self.viewModel openInSpotify];
    
    [self.mockRoutingService verify];
}

@end
