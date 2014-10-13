#import "DetailViewController.h"
#import <KZStorage.h>
#import <KZApplication.h>

@interface DetailViewController () {
    KZStorage * _tasksStorage;
}
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (!_tasksStorage) {
        _tasksStorage = [[taskApplicationDelegate kidozenApplication] StorageWithName:@"tasks"];
    }
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem objectForKey:@"desc"];
        self.titleLabel.text = [self.detailItem objectForKey:@"title"];
        self.categoryLabel.text = [self.detailItem objectForKey:@"category"] ? : @"no-category";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [taskApplicationDelegate.kidozenApplication tagView:@"TaskDetail"];

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//DELETE TASK
- (IBAction)deleteTouch:(id)sender {
    NSString *taskId = [self.detailItem objectForKey:@"_id"];
    [taskApplicationDelegate.kidozenApplication tagClick:@"deleteButton"];

    [_tasksStorage deleteUsingId:taskId withBlock:^(KZResponse * k) {
        NSAssert(!k.error, @"error must be null");
        NSString *category = [self.detailItem objectForKey:@"category"];
        if (category == nil) {
            category = @"no-category";
        }
        
        [taskApplicationDelegate.kidozenApplication tagEvent:@"Task Deleted" attributes:@{@"category": category}];

    }];
}
//UPDATE TASK
- (IBAction)completeTouch:(id)sender {
    NSString *taskId = [self.detailItem objectForKey:@"_id"];

    NSMutableDictionary *updatedTask = [NSMutableDictionary dictionaryWithDictionary:self.detailItem];
    [updatedTask setObject:[NSNumber numberWithBool:true] forKey:@"completed"];
    [taskApplicationDelegate.kidozenApplication tagClick:@"completeButton"];

    [_tasksStorage updateUsingId:taskId object:updatedTask completion:^(KZResponse * k) {
        NSAssert(!k.error, @"error must be null");
        NSString *category = [self.detailItem objectForKey:@"category"];

        if (category == nil) {
            category = @"no-category";
        }
        
        [taskApplicationDelegate.kidozenApplication tagEvent:@"Task Completed" attributes:@{@"category": category}];

    }];
}

//SEND EMAIL
- (IBAction)sendTouch:(id)sender {
    
    [taskApplicationDelegate.kidozenApplication tagClick:@"sendEmailButton"];
    
    [[taskApplicationDelegate kidozenApplication] sendMailTo:@"nicolas.miyasato@kidozen.com"
                                                        from:@"nicolas.miyasato@kidozen.com"
                                                 withSubject:[self.detailItem objectForKey:@"title"]
                                                 andHtmlBody:@""
                                                 andTextBody:[self.detailItem objectForKey:@"desc"]
                                                  completion:^(KZResponse * k)
    {
        
        NSAssert(!k.error, @"error must be null");
        [taskApplicationDelegate.kidozenApplication tagEvent:@"sent email"
                                                  attributes:@{@"mailTo": @"somebody@gmail.com", @"mailFrom:" : @"somebody@nowhere.com"}];
    }];
    
}
@end
