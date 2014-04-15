//
//  NewTaskViewController.m
//  tasks
//
//  Created by Nicolas Miyasato on 4/14/14.
//  Copyright (c) 2014 Tellago Studios. All rights reserved.
//

#import "NewTaskViewController.h"
#import "UIView+Frame.h"

static CGFloat kIOS7FrameOffset = 64;
static CGFloat kNavigationBarOffset = 64;

@interface NewTaskViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation NewTaskViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New Task";

    [self registerForKeyboardNotifications];
    [self addHideTapGestureRecognizer];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {

        self.automaticallyAdjustsScrollViewInsets  = NO;
        self.scrollView.frameY = kIOS7FrameOffset;
        
    }
#endif
    CGSize sz  = [UIScreen mainScreen].bounds.size;
    sz.height = sz.height - self.scrollView.frameY;
    
    self.scrollView.frameSize = sz;
    self.scrollView.contentSize = CGSizeMake(320, self.okButton.frameMaxY + 5);

    [self addCancelButton];
    
    self.titleTextField.accessibilityLabel = @"titleTextField";
    self.descriptionTextView.accessibilityLabel = @"descriptionTextView";
    self.okButton.accessibilityLabel = @"okButton";

}

- (void)addHideTapGestureRecognizer
{
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gr];
}

- (void)hideKeyboard
{
    if ([self.titleTextField isFirstResponder]) {
        [self.titleTextField resignFirstResponder];
    } else if ([self.descriptionTextView isFirstResponder]) {
        [self.descriptionTextView resignFirstResponder];
    }
}

- (IBAction)okButtonPressed:(id)sender {
    
    if ([self.titleTextField.text length] > 0 &&
        [self.descriptionTextView.text length] > 0) {
        
        if (self.didEnterNewTask != nil) {
            NSString *titleString = self.titleTextField.text;
            NSString *description = self.descriptionTextView.text;
            self.didEnterNewTask(titleString, description);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void) addCancelButton
{
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(cancel)];
    cancelButton.accessibilityLabel = @"cancelButton";
    self.navigationItem.leftBarButtonItem = cancelButton;

}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGFloat keyboardHeight = [self heightForKeyboardInNotification:notification];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.scrollView.frameHeight = [UIScreen mainScreen].bounds.size.height - kNavigationBarOffset - keyboardHeight;
        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                                 self.okButton.frameMaxY + 5);

    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGFloat offset = IS_IOS_VERSION_7_OR_GREATER ? kIOS7FrameOffset : kNavigationBarOffset;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.scrollView.frameHeight = [UIScreen mainScreen].bounds.size.height - offset;

        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                                self.okButton.frameMaxY + 5);

    } completion:nil];
}

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(CGFloat) heightForKeyboardInNotification:(NSNotification*)aNotification {
    
    NSDictionary* info = [aNotification userInfo];
    CGSize size = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        return size.height;
    } else {
        return size.width;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    UIView *accessoryView=[[[NSBundle mainBundle] loadNibNamed:@"CancelDoneToolBar"
                                                         owner:self
                                                       options:nil]
                           lastObject];
    
    
    textField.inputAccessoryView=accessoryView;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.descriptionTextView becomeFirstResponder];
    return NO;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UIView *accessoryView=[[[NSBundle mainBundle] loadNibNamed:@"CancelDoneToolBar"
                                                         owner:self
                                                       options:nil]
                           lastObject];

    textView.inputAccessoryView = accessoryView;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

- (IBAction)donePressed:(id)sender
{
    [self hideKeyboard];
}

@end
