//
//  DDMessageView.m
//  Lumpy
//
//  Created by Steven Schofield on 26/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "DDMessageView.h"
#import "DDDraggableView.h"

@interface DDMessageView ()
@property(nonatomic, strong) DDDraggableView *draggableView;
@end

@implementation DDMessageView

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self loadDraggableCustomView];
    
    return self;
}

- (void)loadDraggableCustomView
{
    self.draggableView = [[DDDraggableView alloc] initWithFrame:CGRectMake(60, 60, 200, 260)];
    
    [self addSubview:self.draggableView];
}




@end
