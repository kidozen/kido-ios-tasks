//
//  UIView+Frame.h
//  tasks
//
//  Created by Nicolas Miyasato on 4/14/14.
//  Copyright (c) 2014 Tellago Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;
@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic) CGSize frameSize;
@property (nonatomic) CGPoint frameOrigin;

@property (nonatomic) CGFloat frameMaxX;
@property (nonatomic) CGFloat frameMaxY;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@end
