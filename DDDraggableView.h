//
//  DDDraggableView.h
//  Lumpy
//
//  Created by Steven Schofield on 26/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class DDOVerlayView;

@interface DDDraggableView : UIView

@property (nonatomic, strong) PFObject *message;

@end
