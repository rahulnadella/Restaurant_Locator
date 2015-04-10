/*
 The MIT License (MIT)
 
 Copyright (c) 2015 Rahul Nadella https://github.com/rahulnadella
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "CategoryTableViewController.h"
#import "CategoryCell.h"
#import "VenueViewController.h"

@interface CategoryTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSMutableArray *filteredCategories;
@property (weak, nonatomic) IBOutlet UISearchBar *categorySearchBar;

@end

@implementation CategoryTableViewController

#pragma mark - Properties

@synthesize categories = _categories;

- (NSArray *)categories
{
    if (_categories)
    {
        /* Path to the plist (in the application bundle) */
        NSString *path = [[NSBundle mainBundle] pathForResource:CATEGORIES ofType:PLIST];
        
        _categories = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _categories;
}

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    /* Dispose of any resources that can be recreated. */
    self.categories = nil;
    self.filteredCategories = nil;
    self.categorySearchBar = nil;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self navigationItem] setTitle:@"Food Categories"];
    
    /* Path to the plist (in the application bundle) */
    NSString *path = [[NSBundle mainBundle] pathForResource:CATEGORIES ofType:PLIST];
    /* Allocate/Initialize the plist file */
    self.categories = [[NSArray alloc] initWithContentsOfFile:path];
    self.filteredCategories = [[NSMutableArray alloc] initWithArray:self.categories];
    
    /* Defining the Category Search Bar */
    self.categorySearchBar.delegate = self;
    self.categorySearchBar.placeholder = @"Search for Specific Restaurant Category";
    
    /* Self-Sizing UITableViewCell */
    self.tableView.estimatedRowHeight = 44.0; // set to whatever your "average" cell height is
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.categorySearchBar becomeFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /* Return the sorted by search results */
    return [self.filteredCategories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    categoryCell.title.text = [[self.filteredCategories objectAtIndex:indexPath.row] valueForKey:CATEGORY_NAME];
    
    NSString *imageName = [[self.filteredCategories objectAtIndex:indexPath.row] valueForKey:PREFIX];
    /* Create the desired path based on the prefix and suffix of the specific Category */
    NSString *imageUrl = [NSString stringWithFormat:@"%@bg_32.png", imageName];
    /* Retrieve the Category image */
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    categoryCell.categoryImage.image = [UIImage imageWithData:imageData];
    
    return categoryCell;
}

#pragma mark - UISearchBar methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0)
    {
        [self.filteredCategories removeAllObjects];
        [self.filteredCategories addObjectsFromArray:self.categories];
    }
    else
    {
        [self.filteredCategories removeAllObjects];
        for (NSDictionary *item in self.categories)
        {
            NSString *categoryName = [item valueForKey:CATEGORY_NAME];
            NSRange range = [categoryName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound)
            {
                [self.filteredCategories addObject:item];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    [self.categorySearchBar resignFirstResponder];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *currentCategory = [self.categories objectAtIndex:indexPath.row];
    NSString *categoryId = [currentCategory objectForKey:CATEGORY_ID];
    
    if ([segue.identifier isEqualToString:@"Show Current Venues"])
    {
        if ([segue.destinationViewController isKindOfClass:[VenueViewController class]])
        {
            VenueViewController *vvc = segue.destinationViewController;
            vvc.currentCategoryId = categoryId;
        }
    }
}


@end
