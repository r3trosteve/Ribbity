//
//  DDDraggableView.m
//  Lumpy
//
//  Created by Steven Schofield on 26/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "DDDraggableView.h"
#import "DDOverlayView.h"

@interface DDDraggableView ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic) CGPoint originalPoint;
@property(nonatomic, strong) DDOverlayView *overlayView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation DDDraggableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
    
    [self loadImageAndStyle];
    
    self.overlayView = [[DDOverlayView alloc] initWithFrame:self.bounds];
    self.overlayView.alpha = 0;
    [self addSubview:self.overlayView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadImage:)
                                                 name:@"ImageLoadedNotification"
                                               object:nil];
    
    return self;
}

- (void)loadImageAndStyle
{
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar"]];
    [self addSubview:self.imageView];
    self.layer.cornerRadius = 12;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 0.4;
    self.layer.shouldRasterize = YES;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = (__bridge CGColorRef)([UIColor darkGrayColor]);
    self.layer.borderWidth = 1.0;
}


- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.originalPoint = self.center;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            CGFloat rotationStrength = MIN(xDistance / 320, 1);
            CGFloat rotationAngel = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGFloat scaleStrength = 1 - fabsf(rotationStrength) / 4;
            CGFloat scale = MAX(scaleStrength, 0.93);
            CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
            CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
            self.transform = scaleTransform;
            self.center = CGPointMake(self.originalPoint.x + xDistance, self.originalPoint.y + yDistance);
            
            [self updateOverlay:xDistance];
            
            break;
        };
        case UIGestureRecognizerStateEnded: {
            [self resetViewPositionAndTransformations];
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        self.overlayView.mode = GGOverlayViewModeRight;
    } else if (distance <= 0) {
        self.overlayView.mode = GGOverlayViewModeLeft;
    }
    CGFloat overlayStrength = MIN(fabsf(distance) / 100, 0.4);
    self.overlayView.alpha = overlayStrength;
}

- (void)resetViewPositionAndTransformations
{
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.center = self.originalPoint;
                         self.transform = CGAffineTransformMakeRotation(0);
                         self.overlayView.alpha = 0;
                     }];
}

- (void)dealloc
{
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

#pragma mark - Helper Method

- (void)loadImage:(NSNotification *)notification {
    UIImage *image = [notification.userInfo valueForKey:@"image"];
    self.imageView.image = image;
    NSLog(@"Load Image");
}



@end
