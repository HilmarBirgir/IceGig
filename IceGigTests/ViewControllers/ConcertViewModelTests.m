//
//  ConcertViewModelTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ConcertViewModel.h"

#import "NetworkingService.h"
#import "RoutingService.h"
#import "APIEndpoints.h"
#import "ErrorMessages.h"
#import "ConcertCellViewModel.h"
#import "LoadingCellViewModel.h"
#import "NoResultsCellViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ConcertViewModelTests : UnitTestCase

@property (readwrite, nonatomic) ConcertViewModel *viewModel;

@end

@implementation ConcertViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.viewModel = [[ConcertViewModel alloc] initWithNetworkingService:self.mockNetworkingService
                                                          routingService:self.mockRoutingService];
}

- (void)test_cell_view_models_are_just_one_loading_view_model_initially
{
    [self.viewModel viewDidLoad];

    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    id firstViewModel = self.viewModel.cellViewModels[0];
    
    XCTAssertTrue([firstViewModel isKindOfClass:[LoadingCellViewModel class]]);
}

- (void)test_successful_concert_data_download_sets_view_models_up_correctly
{
    RACSubject *dataSignal = [RACSubject subject];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:CONCERT_URL];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *data = @{@"results": @[[self sampleConcertData], [self sampleConcertData], [self sampleConcertData]]};

    [dataSignal sendNext:data];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 3);
    
    ConcertCellViewModel *firstViewModel = (ConcertCellViewModel *)self.viewModel.cellViewModels[0];
    
    XCTAssertEqualObjects(firstViewModel.name, @"Björgvin Halldórsson");
}

- (void)test_successful_download_with_no_results_sets_cell_as_no_results
{
    RACSubject *dataSignal = [RACSubject subject];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:CONCERT_URL];
    
    [self.viewModel viewDidLoad];
    
    NSDictionary *data = @{@"results": @[]};
    
    [dataSignal sendNext:data];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    NoResultsCellViewModel *firstViewModel = (NoResultsCellViewModel *)self.viewModel.cellViewModels[0];
    
    XCTAssertEqualObjects(firstViewModel.message, NO_CONCERTS_FOUND_ERROR);
}

- (void)test_failed_concert_data_download_shows_error_on_routing_service_and_resets_cell_view_models
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:CONCERT_DOWNLOAD_FAILED_ERROR];
    
    RACSubject *dataSignal = [RACSubject subject];
    
    [[[self.mockNetworkingService stub] andReturn:dataSignal] getJsonFromUrl:CONCERT_URL];

    [self.viewModel viewDidLoad];

    NSError *error = [NSError new];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 1);
    
    [dataSignal sendError:error];
    
    XCTAssertEqual([self.viewModel.cellViewModels count], 0);
    
    [self.mockRoutingService verify];
}

@end
