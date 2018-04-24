//
//  TKTMoviesListTableViewController.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTMoviesListTableViewController.h"

#import "UIViewController+TKTExtras.h"

#import "TKTErrorsManagerNotificationsIndex.h"

#import "TKTDataManager.h"
#import "TKTMovie.h"
#import "TKTSearch.h"
#import "TKTMetadata.h"
#import "TKTError.h"

#import "TKTMoviesListTableViewCell.h"
#import "TKTGenericErrorTableViewCell.h"
#import "TKTNoInternetErrorTableViewCell.h"

@interface TKTMoviesListTableViewController ()

@property (copy, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) TKTMetadata *metadata;

@property (copy, nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation TKTMoviesListTableViewController {
    BOOL _isLoadingData;
    TKTError *_serviceError;
}

static NSString * const kReuseIdentifierData = @"DataCell";
static NSString * const kReuseIdentifierBottomLoader = @"BottomLoaderTVC";
static NSString * const kReuseIdentifierFullLoader = @"FullLoaderTVC";
static NSString * const kReuseIdentifierEmpty = @"EmptyTVC";
static NSString * const kReuseIdentifierGenericError = @"GenericErrorTVC";
static NSString * const kReuseIdentifierNoInternetError = @"NoInternetErrorTVC";

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _data = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupObservers];
    [self setupTableView];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup

- (void)setupObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenForRetryConnection) name:TKTNotificationKeyErrorNoConnection object:NULL];
}

- (void)setupTableView {
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100.0f;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self
                            action:@selector(doPullToRefresh)
                  forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Setters

- (void)setSearchString:(NSString *)searchString {
    
    _searchString = searchString;
    [self reloadData];
}

#pragma mark - Data

- (void)listenForRetryConnection {
    
    if (self.isVisible) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:TKTNotificationKeyInternetIsReachable object:NULL];
}

- (void)removeRetryConnectionObserver {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TKTNotificationKeyInternetIsReachable object:self];
}

- (void)loadData {
    
    [self loadMoreNotificationsOfNextPage:NO];
}

- (void)reloadData {
    
    [self.dataTask cancel];
    self.dataTask = NULL;
    self->_isLoadingData = NO;
    [self.data removeAllObjects];
    self.metadata = NULL;
    [self.tableView reloadData];
    [self loadData];
}

- (void)loadMoreNotificationsOfNextPage:(BOOL)nextPage {
    
    [self removeRetryConnectionObserver];
    
    if (_isLoadingData) return;
    _isLoadingData = YES;
    
    if (self.data.count==0) nextPage = YES;
    if (!nextPage) {
        self->_isLoadingData = NO;
        return;
    }
    
    _serviceError = NULL;
    if (self.searchString) {
        self.dataTask = [[TKTDataManager sharedInstance] GET_moviesWithSearchString:self.searchString
                                                                               page:@(self.metadata.currentPage.unsignedIntegerValue + 1)
                                                                       extendedData:YES
                                                                            success:^(NSArray<TKTSearch *> *searchs, TKTMetadata *metadata) {
                                                                                
                                                                                [self.data addObjectsFromArray:searchs];
                                                                                self.metadata = metadata;
                                                                                
                                                                                [self.tableView reloadData];
                                                                                [self.refreshControl endRefreshing];
                                                                                
                                                                                self->_isLoadingData = NO;
                                                                            }
                                                                            failure:^(TKTError *error) {
                                                                                self->_isLoadingData = NO;
                                                                                self->_serviceError = error;
                                                                                
                                                                                [self.tableView reloadData];
                                                                            }];
    }else{
        self.dataTask = [[TKTDataManager sharedInstance] GET_moviesPopularWithPage:@(self.metadata.currentPage.unsignedIntegerValue + 1)
                                                                      extendedData:YES
                                                                           success:^(NSArray<TKTMovie *> *movies, TKTMetadata *metadata) {
                                                                               
                                                                               [self.data addObjectsFromArray:movies];
                                                                               self.metadata = metadata;
                                                                               
                                                                               [self.tableView reloadData];
                                                                               [self.refreshControl endRefreshing];
                                                                               
                                                                               self->_isLoadingData = NO;
                                                                           }
                                                                           failure:^(TKTError *error) {
                                                                               self->_isLoadingData = NO;
                                                                               self->_serviceError = error;
                                                                               
                                                                               [self.tableView reloadData];
                                                                           }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (self.metadata) {
        if (self.data.count==0) {
            [tableView setScrollEnabled:NO];
            return 1;
        }else{
            // Is loading a new page
            [tableView setScrollEnabled:YES];
            return self.data.count + (self.metadata.hasMorePages?1:0);
        }
    }else{
        // Is loading initial data
        [tableView setScrollEnabled:NO];
        return (tableView.frame.size.height/112)+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (self.metadata) {
        if (self.data.count>0) {
            if (self.metadata.hasMorePages && indexPath.row==([self tableView:tableView numberOfRowsInSection:indexPath.section]-1)) {
                cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierBottomLoader forIndexPath:indexPath];
            }else{
                
                TKTMoviesListTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierData forIndexPath:indexPath];
                
                TKTMovie *movie = [self movieAtIndex:indexPath.row];
                
                [movieCell setMovie:movie];
                
                cell = movieCell;
            }
        }else{
            UITableViewCell *emptyCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierEmpty forIndexPath:indexPath];
            
            cell = emptyCell;
        }
    }else{
        if (_serviceError) {
            switch (_serviceError.type) {
                case TKTErrorTypeNoNetworkConnectionError: {
                    TKTNoInternetErrorTableViewCell *errorCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierNoInternetError forIndexPath:indexPath];
                    
                    [errorCell setError:_serviceError];
                    
                    cell = errorCell;
                    break;
                }
                    
                default: {
                    TKTGenericErrorTableViewCell *errorCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierGenericError forIndexPath:indexPath];
                    
                    [errorCell setError:_serviceError
                                 target:self
                          retrySelector:@selector(loadData)];
                    
                    cell = errorCell;
                    break;
                }
            }
        } else {
            UITableViewCell *fullLoaderCell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifierFullLoader forIndexPath:indexPath];
            
            cell = fullLoaderCell;
        }
    }
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.metadata.hasMorePages && indexPath.row==([self tableView:tableView numberOfRowsInSection:indexPath.section]-1)) {
        [self loadMoreNotificationsOfNextPage:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.metadata) {
        if (self.data.count>0) {
            if (self.metadata.hasMorePages && indexPath.row==([self tableView:tableView numberOfRowsInSection:indexPath.section]-1)) {
                return 40.0f;
            }else{
                return UITableViewAutomaticDimension;
            }
        }else{
            return tableView.frame.size.height;
        }
    }else{
        return tableView.frame.size.height;
    }
}

#pragma mark - Actions

- (void)doPullToRefresh {
    
    [self reloadData];
}

#pragma mark - Helpers

- (TKTMovie *)movieAtIndex:(NSInteger)index {
    
    TKTMovie *movieToReturn;
    if (self.searchString) {
        TKTSearch *search = [self.data objectAtIndex:index];
        movieToReturn = search.movie;
    }else{
        movieToReturn = [self.data objectAtIndex:index];
    }
    
    return movieToReturn;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
