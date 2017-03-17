//
//  SongViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "SongViewModel.h"
#import "Artist.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "ErrorMessages.h"
#import "APIEndpoints.h"
#import "SongCellViewModel.h"
#import "LoadingCellViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface SongViewModelTests : UnitTestCase

@property (readwrite, nonatomic) SongViewModel *viewModel;

@end

@implementation SongViewModelTests

- (void)setUp
{
    [super setUp];
    
    Artist *artist = [self sampleArtist];
    
    self.viewModel = [[SongViewModel alloc] initWithArtist:artist
                                         networkingService:self.mockNetworkingService
                                            routingService:self.mockRoutingService];
}

- (void)test_cell_view_models_are_just_one_loading_view_model_initially
{
    [self.viewModel viewDidLoad];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    id firstViewModel = self.viewModel.cellViewModels[0];
    
    XCTAssertTrue([firstViewModel isKindOfClass:[LoadingCellViewModel class]]);
}

- (void)test_successful_song_data_download_sets_view_models_up_correctly
{
    RACSubject *dataSignal = [RACSubject subject];
    
    NSString *url = [NSString stringWithFormat:TOP_TRACKS_URL, @"123"];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:url parameters:@{@"country": @"IS"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *data = @{@"tracks": @[[self sampleSongData], [self sampleSongData], [self sampleSongData]]};
    
    [dataSignal sendNext:data];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 3);
    
    SongCellViewModel *firstViewModel = (SongCellViewModel *)self.viewModel.cellViewModels[0];
    
    XCTAssertEqualObjects(firstViewModel.name, @"Calling your name");
}

- (void)test_failed_song_data_download_shows_error_on_routing_service_and_resets_cell_view_models
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:SONG_DOWNLOAD_FAILED_ERROR];
    
    RACSubject *dataSignal = [RACSubject subject];
    
    NSString *url = [NSString stringWithFormat:TOP_TRACKS_URL, @"123"];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:url parameters:@{@"country": @"IS"}];
    
    [self.viewModel viewDidLoad];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    [dataSignal sendError:nil];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 0);
    
    [self.mockRoutingService verify];
}

- (void)test_did_select_at_index_shows_player_on_router
{
    [[self.mockRoutingService expect] showPlayerViewController:OCMOCK_ANY];
    
    RACSubject *dataSignal = [RACSubject subject];
    
    NSString *url = [NSString stringWithFormat:TOP_TRACKS_URL, @"123"];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:url parameters:@{@"country": @"IS"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *data = @{@"tracks": @[[self sampleSongData], [self sampleSongData], [self sampleSongData]]};
    
    [dataSignal sendNext:data];
    
    [self.viewModel didSelectCellAtIndex:1];

    [self.mockRoutingService verify];
}

@end
