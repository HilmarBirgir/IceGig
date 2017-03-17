//
//  ArtistViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ArtistViewModel.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "APIEndpoints.h"
#import "ErrorMessages.h"
#import "ArtistCellViewModel.h"
#import "LoadingCellViewModel.h"
#import "NoResultsCellViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ArtistViewModelTests : UnitTestCase

@property (readwrite, nonatomic) ArtistViewModel *viewModel;

@end

@implementation ArtistViewModelTests

- (void)setUp
{
    self.viewModel = [[ArtistViewModel alloc] initWithNetworkingService:self.mockNetworkingService
                                                         routingService:self.mockRoutingService];
}

- (void)test_cell_view_models_are_just_one_loading_view_model_initially
{
    [self.viewModel viewDidLoad];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    id firstViewModel = self.viewModel.cellViewModels[0];
    
    XCTAssertTrue([firstViewModel isKindOfClass:[LoadingCellViewModel class]]);
}

- (void)test_successful_concert_and_artist_downloads_correctly_set_up_cell_view_models
{
    RACSubject *concertDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:concertDataSignal] getJsonFromUrl:CONCERT_URL];

    RACSubject *artistDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:artistDataSignal] getJsonFromUrl:SEARCH_URL parameters:@{@"q": @"Björgvin Halldórsson", @"type": @"artist"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *concertData = @{@"results": @[[self sampleConcertData]]};
    [concertDataSignal sendNext:concertData];
    
    NSDictionary *artistData = @{@"artists": @{@"items": @[[self sampleArtistData]]}};
    [artistDataSignal sendNext:artistData];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    ArtistCellViewModel *firstViewModel = (ArtistCellViewModel *)self.viewModel.cellViewModels[0];
    
    XCTAssertEqualObjects(firstViewModel.name, @"Young Thug");
}

- (void)test_successful_concert_and_artist_downloads_with_no_results_sets_cell_view_models_as_no_result
{
    RACSubject *concertDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:concertDataSignal] getJsonFromUrl:CONCERT_URL];
    
    RACSubject *artistDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:artistDataSignal] getJsonFromUrl:SEARCH_URL parameters:@{@"q": @"Björgvin Halldórsson", @"type": @"artist"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *concertData = @{@"results": @[[self sampleConcertData]]};
    [concertDataSignal sendNext:concertData];
    
    NSDictionary *artistData = @{@"artists": @{@"items": @[]}};
    [artistDataSignal sendNext:artistData];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    NoResultsCellViewModel *firstViewModel = (NoResultsCellViewModel *)self.viewModel.cellViewModels[0];
    
    XCTAssertEqualObjects(firstViewModel.message, NO_ARTIST_FOUND_ERROR);
}

- (void)test_failed_concert_download_shows_error_on_router_and_resets_cell_view_models
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:ARTIST_DOWNLOAD_FAILED_ERROR];

    RACSubject *concertDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:concertDataSignal] getJsonFromUrl:CONCERT_URL];
    
    [self.viewModel viewDidLoad];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);

    [concertDataSignal sendError:nil];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 0);
    
    [self.mockRoutingService verify];
}

- (void)test_successful_concert_download_and_failed_artist_download_shows_error_on_router_and_resets_cell_view_models
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:ARTIST_DOWNLOAD_FAILED_ERROR];
    
    RACSubject *concertDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:concertDataSignal] getJsonFromUrl:CONCERT_URL];
    
    RACSubject *artistDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:artistDataSignal] getJsonFromUrl:SEARCH_URL parameters:@{@"q": @"Björgvin Halldórsson", @"type": @"artist"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *concertData = @{@"results": @[[self sampleConcertData]]};
    [concertDataSignal sendNext:concertData];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    [artistDataSignal sendError:nil];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 0);
    
    [self.mockRoutingService verify];
}

- (void)test_did_selec_cell_at_index_shows_song_view_controller_on_router
{
    [[self.mockRoutingService expect] showSongViewController:OCMOCK_ANY];
    
    RACSubject *concertDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:concertDataSignal] getJsonFromUrl:CONCERT_URL];
    
    RACSubject *artistDataSignal = [RACSubject subject];
    [[[self.mockNetworkingService stub] andReturn:artistDataSignal] getJsonFromUrl:SEARCH_URL parameters:@{@"q": @"Björgvin Halldórsson", @"type": @"artist"}];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *concertData = @{@"results": @[[self sampleConcertData]]};
    [concertDataSignal sendNext:concertData];
    
    NSDictionary *artistData = @{@"artists": @{@"items": @[[self sampleArtistData]]}};
    [artistDataSignal sendNext:artistData];
    
    [self.viewModel didSelectCellAtIndex:0];
    
    [self.mockRoutingService verify];
}

@end
