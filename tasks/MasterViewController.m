#import "MasterViewController.h"
#import "TasksViewController.h"
#import "NewTaskAlertView.h"
#import <KZStorage.h>

@interface MasterViewController () {
    NSMutableArray *_objects;
    NewTaskAlertView * _newTaskAlertView;
    KZStorage * _tasksStorage;
}

@end


@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)insertNewTask:(id)sender
{
    _newTaskAlertView = [[NewTaskAlertView alloc] initWithTitle:@"New task" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitle:@"Ok"];
    [_newTaskAlertView show];
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

// CREATE TASK

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!_tasksStorage) {
        _tasksStorage = [[taskApplicationDelegate kidozenApplication] StorageWithName:@"tasks"];
    }

    NSDictionary * t = [NSDictionary dictionaryWithObjectsAndKeys:
                        [[_newTaskAlertView titleTextField] text],@"title",
                        [[_newTaskAlertView descriptionTextField] text], @"desc",
                        [NSNumber numberWithBool:false], @"completed",
                        nil];
    [_tasksStorage create:t completion:^(KZResponse * kr) {
        NSAssert(!kr.error, @"error must be null");
    }];
}

@end
