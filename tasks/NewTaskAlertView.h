#import <UIKit/UIKit.h>

@interface NewTaskAlertView : UIAlertView <UITableViewDelegate, UITableViewDataSource> {
@private
	UITableView *tableView;
	UITextField *taskTitleTextField;
	UITextField *taskDescriptionTextField;
}

@property(nonatomic, retain, readonly) UITextField *titleTextField;
@property(nonatomic, retain, readonly) UITextField *descriptionTextField;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles;

@end