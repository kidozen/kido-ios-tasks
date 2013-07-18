#import "NewTaskAlertView.h"

@interface NewTaskAlertView ()
@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) UITextField *titleTextField;
@property(nonatomic, retain) UITextField *descriptionTextField;
- (void)orientationDidChange:(NSNotification *)notification;
@end


@implementation NewTaskAlertView

@synthesize tableView = tableView;
@synthesize titleTextField = taskTitleTextField;
@synthesize descriptionTextField = taskDescriptionTextField;

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles {
    
	if ((self = [super initWithTitle:title message:@"\n\n\n" delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil])) {
		// FIXME: This is a workaround. By uncomment below, UITextFields in tableview will show characters when typing (possible keyboard reponder issue).
		[self addSubview:self.titleTextField];
        
		tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		tableView.delegate = self;
		tableView.dataSource = self;
		tableView.scrollEnabled = NO;
		tableView.opaque = NO;
//		tableView_.layer.cornerRadius = 3.0f;
		tableView.editing = YES;
		tableView.rowHeight = 28.0f;
		[self addSubview:tableView];
        
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
	[tableView setDataSource:nil];
	[tableView setDelegate:nil];
}

#pragma mark layout

- (void)layoutSubviews {
	// We assume keyboard is on.
	if ([[UIDevice currentDevice] isGeneratingDeviceOrientationNotifications]) {
		if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
			self.center = CGPointMake(160.0f, (460.0f - 216.0f)/2 + 12.0f);
			self.tableView.frame = CGRectMake(12.0f, 51.0f, 260.0f, 56.0f);
		} else {
			self.center = CGPointMake(240.0f, (300.0f - 162.0f)/2 + 12.0f);
			self.tableView.frame = CGRectMake(12.0f, 35.0f, 260.0f, 56.0f);
		}
	}
}

- (void)orientationDidChange:(NSNotification *)notification {
	[self setNeedsLayout];
}

#pragma mark Accessors

- (UITextField *)titleTextField {
    
	if (!taskTitleTextField) {
		taskTitleTextField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 255.0f, 28.0f)];
		taskTitleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		taskTitleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		taskTitleTextField.placeholder = @"Title";
	}
	return taskTitleTextField;
}

- (UITextField *)descriptionTextField {
    
	if (!taskDescriptionTextField) {
		taskDescriptionTextField = [[UITextField alloc] initWithFrame:CGRectMake(5.0f, 0.0f, 255.0f, 28.0f)];
		taskDescriptionTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		taskDescriptionTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		taskDescriptionTextField.placeholder = @"desc";
	}
	return taskDescriptionTextField;
}

#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *AlertPromptCellIdentifier = @"DDAlertPromptCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:AlertPromptCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AlertPromptCellIdentifier];
    }
    
	if (![cell.contentView.subviews count]) {
		if (indexPath.row) {
			[cell.contentView addSubview:self.descriptionTextField];
		} else {
			[cell.contentView addSubview:self.titleTextField];
		}
	}
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

@end
