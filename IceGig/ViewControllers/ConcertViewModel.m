//
//  ConcertListViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 11/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ConcertViewModel.h"

#import "Application+Singletons.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "APIEndpoints.h"
#import "ErrorMessages.h"
#import "Concert.h"
#import "ConcertCellViewModel.h"
#import "LoadingCellViewModel.h"
#import "NoResultsCellViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ConcertViewModel ()

@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) RoutingService *routingService;

@property (readwrite, nonatomic) NSArray<id<CellViewModel>> *cellViewModels;
@property (readwrite, nonatomic) NSString *title;
@property (readwrite, nonatomic) BOOL hasPullToRefresh;

@end

@implementation ConcertViewModel

- (instancetype)init
{
    return [self initWithNetworkingService:[Application sharedNetworkingService]
                            routingService:[Application sharedRoutingService]];
}

- (instancetype)initWithNetworkingService:(NetworkingService *)networkingService
                           routingService:(RoutingService *)routingService
{
    self = [super init];
    
    if (self)
    {
        self.networkingService = networkingService;
        self.routingService = routingService;
        
        self.title = @"Upcoming";
        self.hasPullToRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [self downloadConcerts];
}

- (void)pullToRefresh
{
    [self downloadConcerts];
}

- (void)downloadConcerts
{
    self.cellViewModels = @[[LoadingCellViewModel new]];
    
    @weakify(self);
    
    [[[self.networkingService getJsonFromUrl:CONCERT_URL] map:^id _Nullable(NSDictionary *concertsData) {
        NSMutableArray<id<CellViewModel>> *cellViewModels = [NSMutableArray new];
        
        for (NSDictionary *concertData in concertsData[@"results"])
        {
            Concert *concert = [[Concert alloc] initWithData:concertData];
            ConcertCellViewModel *cellViewModel = [[ConcertCellViewModel alloc] initWithConcert:concert];
            [cellViewModels addObject:cellViewModel];
        }
        
        if ([cellViewModels count] == 0)
        {
            NoResultsCellViewModel *noConcertsCellViewModel = [[NoResultsCellViewModel alloc] initWithMessage:NO_CONCERTS_FOUND_ERROR];
            [cellViewModels addObject:noConcertsCellViewModel];
        }
        
        return cellViewModels;
    }] subscribeNext:^(NSArray<ConcertCellViewModel *> *cellViewModels) {
        @strongify(self);
        self.cellViewModels = cellViewModels;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        [self.routingService showErrorAlertWithMessage:CONCERT_DOWNLOAD_FAILED_ERROR];
        self.cellViewModels = @[];
    }];
}

@end
