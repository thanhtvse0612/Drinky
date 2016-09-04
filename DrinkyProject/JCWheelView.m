//
//  JCWheelView.m
//  JCWheelView
//
//  Created by 李京城 on 15/6/27.
//  Copyright (c) 2014 李京城. All rights reserved.
//

#import "JCWheelView.h"
#import "JCWheelItem.h"
#import "JCWheelCenterView.h"
#import "JCRotateGestureRecognizer.h"

@implementation JCWheelView
@synthesize baseWheelItem = _baseWheelItem;
@synthesize numberOfItems = _numberOfItems;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.image = [UIImage imageNamed:@"wheel_bg"];

    JCRotateGestureRecognizer *rotateGR = [[JCRotateGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotateGesture:)];
    [self addGestureRecognizer:rotateGR];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    frame.size.height = frame.size.width;
    self.frame = frame;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self.image drawInRect:rect];
    
    CGFloat radius = rect.size.height/2;
    CGFloat degrees = 270.0f;//the above is the starting point
    
    for (int i = 0; i < self.numberOfItems; i++) {
        JCWheelItem *item = [[JCWheelItem alloc] initWithWheelView:self];
        item.tag = i;
       
        CGFloat centerX = radius + (radius/2 * cos(DEGREES_TO_RADIANS(degrees)));
        CGFloat centerY = radius + (radius/2 * sin(DEGREES_TO_RADIANS(degrees)));
        
        item.center = CGPointMake(centerX, centerY);
        item.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS((degrees + 90.0f)));
        
        degrees += 360/self.numberOfItems;
        
        [self addSubview:item];
    }
    
    self.baseWheelItem.userInteractionEnabled = NO;
    [self.superview insertSubview:self.baseWheelItem aboveSubview:self];
    [self.superview insertSubview:self.centerView aboveSubview:self];
}


- (void)handleRotateGesture:(JCRotateGestureRecognizer *)rotateGR
{
//    if (rotateGR.state == UIGestureRecognizerStateChanged) {//rotate
//        self.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
//    }
//    else
    if(rotateGR.state == UIGestureRecognizerStateEnded) {//tap
        [UIView animateWithDuration:80.0 animations:^{
            CABasicAnimation* rotationAnimation;
            rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 8 + rotateGR.degrees ];
            rotationAnimation.duration = 8.0;
            rotationAnimation.cumulative = YES;
            rotationAnimation.repeatCount = NO;
            [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        } completion:^(BOOL finished) {
            NSLog(@"finish");
            self.transform = CGAffineTransformRotate(self.transform, rotateGR.degrees);
            
            [self performSelector:@selector(showAlert) withObject:nil afterDelay:8.0];
            if ([self.delegate respondsToSelector:@selector(wheelView:didSelectItemAtIndex:)]) {
                [self.delegate wheelView:self didSelectItemAtIndex:rotateGR.seletedIndex];
            }
        }];
    }
}

-(void)showAlert {
    [[Utilities shareInstance] showAlertViewControllerLuckyWheelWithTitle:@"Lucky Wheel"
                                                                  message:@"Congratulation!!!!"
                                                           styleAlertView:LEAlertControllerStyleAlert
                                                             cancelButton:NSLocalizedString(OK_Button_Alert, nil)
                                                           viewController:[[[myAppdelegate startInviteNavigationController] viewControllers] lastObject]
                                                           viewLuckyWheel:self];
}

#pragma mark -

- (JCWheelItem *)baseWheelItem
{
    if (!_baseWheelItem) {
        _baseWheelItem = [[JCWheelItem alloc] initWithWheelView:self];
        
        CGRect baseWheelItemFrame = self.baseWheelItem.frame;
        baseWheelItemFrame.origin.x = (self.frame.size.width - baseWheelItemFrame.size.width)/2 + self.frame.origin.x;
        baseWheelItemFrame.origin.y = self.frame.origin.y;
        
        self.baseWheelItem.frame = baseWheelItemFrame;
    }
    
    return _baseWheelItem;
}

- (JCWheelCenterView *)centerView
{
    if (!_centerView) {
        _centerView = [[JCWheelCenterView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
        _centerView.center = self.center;
    }
    
    return _centerView;
}

- (NSInteger)numberOfItems
{
    if ([self.delegate respondsToSelector:@selector(numberOfItemsInWheelView:)]) {
        _numberOfItems = [self.delegate numberOfItemsInWheelView:self];
    }
    
    return _numberOfItems;
}

@end
