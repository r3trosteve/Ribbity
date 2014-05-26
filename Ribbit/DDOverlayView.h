//
//  DDOverlayView.h
//  Lumpy
//
//  Created by Steven Schofield on 26/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger , GGOverlayViewMode) {
    GGOverlayViewModeLeft,
    GGOverlayViewModeRight
};

@interface DDOverlayView : UIView
@property (nonatomic) GGOverlayViewMode mode;
@end
