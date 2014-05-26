//
//  DDOverlayView.m
//  Lumpy
//
//  Created by Steven Schofield on 26/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "DDOverlayView.h"

@interface DDOverlayView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation DDOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trollface_300x200"]];
    [self addSubview:self.imageView];
    
    return self;
}

- (void)setMode:(GGOverlayViewMode)mode
{
    if (_mode == mode) return;
    
    _mode = mode;
    if (mode == GGOverlayViewModeLeft) {
        self.imageView.image = [UIImage imageNamed:@"trollface_300x200"];
    } else {
        self.imageView.image = [UIImage imageNamed:@"thumbs_up_300x300"];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(50, 50, 100, 100);
}

@end
