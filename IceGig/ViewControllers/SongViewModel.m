//
//  SongViewModel.m
//  IceGig
//
//  Created by Hilmar Birgir Ólafsson on 14/03/2017.
//  Copyright © 2017 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "SongViewModel.h"

#import "Application+Singletons.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "APIEndpoints.h"
#import "ErrorMessages.h"
#import "SongCellViewModel.h"
#import "LoadingCellViewModel.h"
#import "Artist.h"
#import "Song.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface SongViewModel ()

@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) RoutingService *routingService;

@property (readwrite, nonatomic) NSArray<id<CellViewModel>> *cellViewModels;
@property (readwrite, nonatomic) NSString *title;
@property (readwrite, nonatomic) BOOL hasPullToRefresh;

@property (readwrite, nonatomic) Artist *artist;

@end

@implementation SongViewModel

- (instancetype)initWithArtist:(Artist *)artist
{
    return [self initWithArtist:artist
              networkingService:[Application sharedNetworkingService]
                 routingService:[Application sharedRoutingService]];
}

- (instancetype)initWithArtist:(Artist *)artist
             networkingService:(NetworkingService *)networkingService
                routingService:(RoutingService *)routingService
{
    self = [super init];
    
    if (self)
    {
        self.networkingService = networkingService;
        self.routingService = routingService;
        self.artist = artist;
        self.title = artist.name;
        self.hasPullToRefresh = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [self downloadSongs];
}

- (void)pullToRefresh
{
    [self downloadSongs];
}

- (void)didSelectCellAtIndex:(NSInteger)index
{
    SongCellViewModel *cellViewModel = (SongCellViewModel *)self.cellViewModels[index];
    [self.routingService showPlayerViewController:cellViewModel.song];
}

- (void)downloadSongs
{
    self.cellViewModels = @[[LoadingCellViewModel new]];
    
    NSDictionary *parameters = @{@"country": @"IS"};
    
    @weakify(self);
    [[[self.networkingService getJsonFromUrl:[NSString stringWithFormat:TOP_TRACKS_URL, self.artist.ID] parameters:parameters] map:^id _Nullable(NSDictionary *data) {
        NSMutableArray<SongCellViewModel *> *cellViewModels = [NSMutableArray new];
        
        for (NSDictionary *songData in data[@"tracks"])
        {
            Song *song = [[Song alloc] initWithData:songData];
            SongCellViewModel *cellViewModel = [[SongCellViewModel alloc] initWithSong:song];
            [cellViewModels addObject:cellViewModel];
        }
        
        return cellViewModels;
    }] subscribeNext:^(NSArray<SongCellViewModel *> *cellViewModels) {
        @strongify(self);
        self.cellViewModels = cellViewModels;
    } error:^(NSError * _Nullable error) {
        @strongify(self);
        self.cellViewModels = @[];
        [self.routingService showErrorAlertWithMessage:SONG_DOWNLOAD_FAILED_ERROR];
    }];
}

@end
