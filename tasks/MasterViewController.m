#import "MasterViewController.h"
#import "TasksViewController.h"
#import "NewTaskViewController.h"
#import <KZApplication.h>
#import <KZStorage.h>

@interface MasterViewController () {
    NSMutableArray *_objects;
    KZStorage * _tasksStorage;
}

@end


@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewTask:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:@"All" atIndex:0];
    [_objects insertObject:@"Pending" atIndex:0];
    [_objects insertObject:@"Completed" atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

}

- (void)insertNewTask:(id)sender
{
    NewTaskViewController *newTaskVC = [[NewTaskViewController alloc] init];
    newTaskVC.didEnterNewTask = ^(NSString *titleString, NSString *description) {
        if (!_tasksStorage) {
            _tasksStorage = [[taskApplicationDelegate kidozenApplication] StorageWithName:@"tasks"];
        }
        
        NSDictionary *params = @{@"title": titleString,
                                 @"desc": description,
                                 @"completed": @(NO)};
        
        [_tasksStorage create:params completion:^(KZResponse * kr) {
            NSAssert(!kr.error, @"error must be null");
        }];

    };
    
    UINavigationController *newTaskNav = [[UINavigationController alloc] initWithRootViewController:newTaskVC];
    [self.navigationController presentViewController:newTaskNav animated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTasks"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *object = _objects[indexPath.row];
        [[segue destinationViewController] setTasksType:object];
    }
}

@end
