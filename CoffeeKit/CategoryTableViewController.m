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
#import "VenueViewController.h"

@interface CategoryTableViewController ()

@property (nonatomic, strong) NSArray *categories;

@end

@implementation CategoryTableViewController

#pragma mark - Properties

@synthesize categories = _categories;

- (NSArray *)categories
{
    if (_categories)
    {
        /* Path to the plist (in the application bundle) */
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
        
        _categories = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _categories;
}

#pragma mark - Memory Allocation

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self navigationController] setTitle:@"Food Categories"];
    
    // Path to the plist (in the application bundle)
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Categories" ofType:@"plist"];
    
    self.categories = [[NSArray alloc] initWithContentsOfFile:path];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.categories objectAtIndex:indexPath.row] valueForKey:@"categoryName"];
    cell.detailTextLabel.text = [[self.categories objectAtIndex:indexPath.row] valueForKey:@"categoryId"];
    
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *currentCategory = [self.categories objectAtIndex:indexPath.row];
    NSString *categoryId = [currentCategory objectForKey:@"categoryId"];
    
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
