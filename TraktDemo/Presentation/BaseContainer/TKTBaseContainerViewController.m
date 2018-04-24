//
//  TKTBaseContainerViewController.m
//  TraktDemo
//
//  Created by Guillermo Sáenz on 4/24/18.
//

#import "TKTBaseContainerViewController.h"

#import "TKTMoviesListTableViewController.h"

@interface TKTBaseContainerViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation TKTBaseContainerViewController

static NSString * const kSearchControllerSID = @"SearchControllerSID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)setupSearchController {
    
    UIViewController *searchResultController = [[UIStoryboard storyboardWithName:@"TKTMoviesList" bundle:NULL] instantiateViewControllerWithIdentifier:@"TKTMoviesListTableViewController"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"Buscar películas";
    self.navigationItem.searchController = self.searchController;
    self.definesPresentationContext = YES;
}

#pragma mark - <UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    TKTMoviesListTableViewController *searchResultsController = (TKTMoviesListTableViewController *) searchController.searchResultsController;
    searchResultsController.searchString = searchController.searchBar.text;
}

@end
