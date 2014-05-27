//
//  DDImageViewController.m
//  Lumpy
//
//  Created by Steven Schofield on 22/05/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "DDImageViewController.h"
#import "DDMessageView.h"

@interface DDImageViewController ()
@property (nonatomic, strong) NSDictionary *userInfo;
@end

@implementation DDImageViewController

- (void)loadView {
    self.view = [[DDMessageView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // displaying the image
    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    // overriding the view title in top bar
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
    
   self.userInfo = [NSDictionary dictionaryWithObject:[UIImage imageWithData:imageData]
                                                     forKey:@"image"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ImageLoadedNotification"
     object:self
     userInfo:self.userInfo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // conditional statement checks for the selector being implemented
    if ([self respondsToSelector:@selector(timeout)]) {
        // time out the image display after 10 seconds
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    }
    else {
        NSLog(@"selector missing");
    }
}





#pragma mark - Helper Methods

 // timeout selector method will return user back to previous view
- (void)timeout {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
