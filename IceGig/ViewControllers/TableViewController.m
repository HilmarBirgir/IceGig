//
//  TableViewController.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "TableViewController.h"

#import "CellViewModel.h"
#import "ArtistCell.h"
#import "ConcertCell.h"
#import "LoadingCell.h"
#import "SongCell.h"
#import "NoResultsCell.h"
#import "UINib+Class.h"
#import "UIColor+Colors.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface TableViewController ()

@end

@implementation TableViewController

- (instancetype)initWithViewModel:(id<TableViewModel>)viewModel
{
    self = [super init];
    
    if (self)
    {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    [self bindObservers];
    
    if (self.viewModel.hasPullToRefresh)
    {
        [self setupPullToRefresh];
    }
    
    if ([self.viewModel respondsToSelector:@selector(viewDidLoad)])
    {
        [self.viewModel viewDidLoad];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.title = self.viewModel.title;
}

- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, self.tabBarController.tabBar.frame.size.height, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibFromClass:[ArtistCell class]] forCellReuseIdentifier:ARTIST_CELL_REUSE_IDENTIFIER];
    [self.tableView registerNib:[UINib nibFromClass:[ConcertCell class]] forCellReuseIdentifier:CONCERT_CELL_REUSE_IDENTIFIER];
    [self.tableView registerNib:[UINib nibFromClass:[LoadingCell class]] forCellReuseIdentifier:LOADING_CELL_REUSE_IDENTIFIER];
    [self.tableView registerNib:[UINib nibFromClass:[SongCell class]] forCellReuseIdentifier:SONG_CELL_REUSE_IDENTIFIER];
    [self.tableView registerNib:[UINib nibFromClass:[NoResultsCell class]] forCellReuseIdentifier:NO_RESULTS_CELL_REUSE_IDENTIFIER];
}

- (void)setupPullToRefresh
{
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = [UIColor spotifyGreen];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
}

- (void)pullToRefresh
{
    if ([self.viewModel respondsToSelector:@selector(pullToRefresh)])
    {
        [self.viewModel pullToRefresh];
    }
}

- (void)bindObservers
{
    @weakify(self);
    [RACObserve(self.viewModel, cellViewModels) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<CellViewModel> cellViewModel = self.viewModel.cellViewModels[indexPath.row];
    id cell = [tableView dequeueReusableCellWithIdentifier:[cellViewModel reuseIdentifier] forIndexPath:indexPath];
    
    if ([cell respondsToSelector:@selector(setViewModel:)])
    {
        [cell performSelector:@selector(setViewModel:) withObject:cellViewModel];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<CellViewModel> cellViewModel = self.viewModel.cellViewModels[indexPath.row];
    
    return [cellViewModel height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.viewModel respondsToSelector:@selector(didSelectCellAtIndex:)])
    {
        [self.viewModel didSelectCellAtIndex:indexPath.row];
    }
}

@end
