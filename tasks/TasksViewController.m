#import "TasksViewController.h"
#import "DetailViewController.h"
#import <KZStorage.h>
#import <KZApplication.h>


@interface TasksViewController ()
{
    NSMutableArray * _tasks;
    KZStorage * _tasksStorage;
}
@end

@implementation TasksViewController


- (void)setDetailItem:(id)newTaskType
{
    if (_tasksType != newTaskType) {
        _tasksType = newTaskType;
        
        // Update the view.
        [self configureView];
    }
}

//QUERY STORAGE
- (void)configureView
{
    if (self.tasksType) {
            _tasks = [[NSMutableArray alloc] init];
            _tasksStorage = [[taskApplicationDelegate kidozenApplication] StorageWithName:@"tasks"];

            
            if ([_tasksType isEqualToString:@"All"]) {
                [_tasksStorage all:^(KZResponse * k) {
                    [_tasks addObjectsFromArray:[k response]];
                    [self.tableView reloadData];
                }];
            }
            else
            {
                NSString * completed = [_tasksType isEqualToString:@"Completed"] ? @"true" : @"false";
                NSString * queryString = [NSString stringWithFormat:@"{\"completed\":%@}", completed];
                [_tasksStorage query:queryString withBlock:^(KZResponse * k) {
                    [_tasks addObjectsFromArray:[k response]];
                    [self.tableView reloadData];
                }];
            }
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configureView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [taskApplicationDelegate.kidozenApplication tagScreen:@"TasksList"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *task = _tasks[indexPath.row];
    cell.textLabel.text = [task objectForKey:@"title"];
    cell.detailTextLabel.text = [task objectForKey:@"desc"];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailTask"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = _tasks[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
