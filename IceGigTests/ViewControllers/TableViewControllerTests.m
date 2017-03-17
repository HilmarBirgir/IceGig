//
//  TableViewControllerTests.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 16/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "TableViewController.h"
#import "ConcertViewModel.h"
#import "ConcertCellViewModel.h"

// Little cheating here so we can freely update the cell view models.

@interface ConcertViewModel (Testing)

@property (readwrite, nonatomic) NSArray<id<CellViewModel>> *cellViewModels;

@end

@interface TableViewControllerTests : UnitTestCase

@property (readwrite, nonatomic) TableViewController *viewController;
@property (readwrite, nonatomic) ConcertViewModel *viewModel;

@end

@implementation TableViewControllerTests

- (void)setUp
{
    [super setUp];
    
    self.viewModel = [[ConcertViewModel alloc] initWithNetworkingService:self.mockNetworkingService
                                                                       routingService:self.mockRoutingService];
    
    self.viewController = [[TableViewController alloc] initWithViewModel:self.viewModel];
}

- (void)addCellViewModels
{
    ConcertCellViewModel *cellViewModel = [[ConcertCellViewModel alloc] initWithConcert:[self sampleConcert]];
    self.viewModel.cellViewModels = @[cellViewModel, cellViewModel];
}

- (void)test_updating_cell_view_models_on_view_model_reloads_data_on_table_view
{
    id mockTableView = [OCMockObject niceMockForClass:[UITableView class]];
    [[mockTableView expect] reloadData];

    [self.viewController viewDidLoad];
    
    self.viewController.tableView = mockTableView;
    
    [self addCellViewModels];
    
    [mockTableView verify];
}

@end
