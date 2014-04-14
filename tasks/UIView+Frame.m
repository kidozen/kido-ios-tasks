//
//  UIView+Frame.m
//  tasks
//
//  Created by Nicolas Miyasato on 4/14/14.
//  Copyright (c) 2014 Tellago Studios. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


-(CGFloat)frameX
{
    return self.frame.origin.x;
}

-(CGFloat)frameY
{
    return self.frame.origin.y;
}

-(CGFloat)frameWidth
{
    return self.frame.size.width;
}

-(CGFloat)frameHeight
{
    return self.frame.size.height;
}

-(CGSize)frameSize
{
    return self.frame.size;
}

-(CGPoint)frameOrigin
{
    return self.frame.origin;
}

-(void)setFrameX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

-(void)setFrameY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
-(void)setFrameWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
-(void)setFrameHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
-(void)setFrameSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
}
-(void)setFrameOrigin:(CGPoint)origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
}

-(CGFloat)frameMaxX
{
    return CGRectGetMaxX(self.frame);
}
-(CGFloat)frameMaxY
{
    return CGRectGetMaxY(self.frame);
}

-(void)setFrameMaxX:(CGFloat)frameMaxX
{
    self.frameWidth = MAX(frameMaxX - self.frameX, 0);
}

-(void)setFrameMaxY:(CGFloat)frameMaxY
{
    self.frameHeight = MAX(frameMaxY - self.frameY, 0);
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}
-(void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}


@end
