//
//  ArtistViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ArtistViewModel.h"

#import "Application+Singletons.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "APIEndpoints.h"
#import "ErrorMessages.h"
#import "Concert.h"
#import "Artist.h"
#import "ArtistCellViewModel.h"
#import "LoadingCellViewModel.h"
#import "NoResultsCellViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface ArtistViewModel ()

@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) RoutingService *routingService;

@property (readwrite, nonatomic) NSArray<id<CellViewModel>> *cellViewModels;
@property (readwrite, nonatomic) NSString *title;
@property (readwrite, nonatomic) BOOL hasPullToRefresh;

@end

@implementation ArtistViewModel

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
        self.title = @"Listen";
        self.hasPullToRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [self downloadArtists];
}

- (void)pullToRefresh
{
    [self downloadArtists];
}

- (void)didSelectCellAtIndex:(NSInteger)index
{
    ArtistCellViewModel *cellViewModel = (ArtistCellViewModel *)self.cellViewModels[index];
    [self.routingService showSongViewController:cellViewModel.artist];
}

- (void)downloadArtists
{
    self.cellViewModels = @[[LoadingCellViewModel new]];
    
    @weakify(self);
    [[[[self concertDownloadSignal] flattenMap:^__kindof RACSignal * _Nullable(NSArray<Concert *> *concerts) {
        return [self artistsDownloadSignal:concerts];
    }] map:^id _Nullable(RACTuple *tuple) {
        NSArray *artistData = [tuple allObjects];
        NSMutableArray<id<CellViewModel>> *cellViewModels = [NSMutableArray new];
        
        for (NSDictionary *data in artistData)
        {
            NSDictionary *artists = data[@"artists"];
            NSArray *items = artists[@"items"];
            
            if ([items count] > 0)
            {
                NSDictionary *firstResultData = items[0];
                Artist *artist = [[Artist alloc] initWithData:firstResultData];
                ArtistCellViewModel *cellViewModel = [[ArtistCellViewModel alloc] initWithArtist:artist];
                [cellViewModels addObject:cellViewModel];
            }
        }
        
        if ([cellViewModels count] == 0)
        {
            NoResultsCellViewModel *noArtistCellViewModel = [[NoResultsCellViewModel alloc] initWithMessage:NO_ARTIST_FOUND_ERROR];
            [cellViewModels addObject:noArtistCellViewModel];
        }
        
        return cellViewModels;
    }] subscribeNext:^(NSArray<ArtistCellViewModel *> *cellViewModels) {
        @strongify(self);
        self.cellViewModels = cellViewModels;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        [self.routingService showErrorAlertWithMessage:ARTIST_DOWNLOAD_FAILED_ERROR];
        self.cellViewModels = @[];
    }];
}

- (RACSignal *)concertDownloadSignal
{
    return [[self.networkingService getJsonFromUrl:CONCERT_URL] map:^id _Nullable(NSDictionary *concertsData) {
        NSMutableArray *concerts = [NSMutableArray new];
        for (NSDictionary *concertData in concertsData[@"results"])
        {
            Concert *concert = [[Concert alloc] initWithData:concertData];
            [concerts addObject:concert];
        }
        
        return concerts;
    }];
}

- (RACSignal *)artistsDownloadSignal:(NSArray<Concert *> *)concerts
{
    NSMutableSet *searchQueries = [NSMutableSet new];
    
    for (Concert *concert in concerts)
    {
        [searchQueries addObject:concert.name];
    }
    
    NSMutableArray *searchSignals = [NSMutableArray new];
    
    for (NSString *searchQuery in searchQueries)
    {
        NSDictionary *parameters = @{@"q": searchQuery, @"type": @"artist"};
        RACSignal *searchSignal = [self.networkingService getJsonFromUrl:SEARCH_URL parameters:parameters];
        [searchSignals addObject:searchSignal];
    }
    
    return [RACSignal combineLatest:searchSignals];
}

@end
