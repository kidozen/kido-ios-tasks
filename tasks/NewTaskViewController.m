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

@interface NewTaskViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation NewTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {

        self.automaticallyAdjustsScrollViewInsets  = NO;
        self.scrollView.frameY = kIOS7FrameOffset;
        
        CGSize sz  = [UIScreen mainScreen].bounds.size;
        sz.height = sz.height - self.scrollView.frameY;
        
        self.scrollView.frameSize = sz;
    }
    
    self.title = @"New Task";
    
    [self addCancelButton];

}


- (IBAction)okButtonPressed:(id)sender {
    if (self.didEnterNewTask != nil) {
        NSString *titleString = self.titleTextField.text;
        NSString *description = self.descriptionTextView.text;
        self.didEnterNewTask(titleString, description);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) addCancelButton
{
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButton;

}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
