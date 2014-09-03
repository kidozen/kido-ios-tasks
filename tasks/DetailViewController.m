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
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[LocalyticsSession shared] tagScreen:@"TaskDetail"];

    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
//DELETE TASK
- (IBAction)deleteTouch:(id)sender {
    NSString *taskId = [self.detailItem objectForKey:@"_id"];
    [_tasksStorage deleteUsingId:taskId withBlock:^(KZResponse * k) {
        NSAssert(!k.error, @"error must be null");
        [[LocalyticsSession shared] tagEvent:@"TaskDeleted"];

    }];
}
//UPDATE TASK
- (IBAction)completeTouch:(id)sender {
    NSString *taskId = [self.detailItem objectForKey:@"_id"];

    NSMutableDictionary *updatedTask = [NSMutableDictionary dictionaryWithDictionary:self.detailItem];
    [updatedTask setObject:[NSNumber numberWithBool:true] forKey:@"completed"];
    
    [_tasksStorage updateUsingId:taskId object:updatedTask completion:^(KZResponse * k) {
        NSAssert(!k.error, @"error must be null");
        [[LocalyticsSession shared] tagEvent:@"TaskCompleted"];

    }];
}

//SEND EMAIL
- (IBAction)sendTouch:(id)sender {
    
    [[taskApplicationDelegate kidozenApplication] sendMailTo:@"christian.carnero@gmail.com"
                                                        from:@"christian.carnero@tellago.com"
                                                 withSubject:[self.detailItem objectForKey:@"title"]
                                                 andHtmlBody:@""
                                                 andTextBody:[self.detailItem objectForKey:@"desc"]
                                                  completion:^(KZResponse * k)
    {
        
        NSAssert(!k.error, @"error must be null");
        [[LocalyticsSession shared] tagEvent:@"SentMail"];

        
                                                      
    }];
    
}
@end
