//
//  NewTaskViewController.h
//  tasks
//
//  Created by Nicolas Miyasato on 4/14/14.
//  Copyright (c) 2014 Tellago Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskViewController : UIViewController

@property (nonatomic, copy) void (^didEnterNewTask)(NSString *title, NSString *description);

@end
