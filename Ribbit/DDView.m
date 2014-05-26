//
//  DDView.m
//  
//
//  Created by Steven Schofield on 26/05/2014.
//
//

#import "DDView.h"
#import "DDMessageView.h"

@interface DDView ()

@end

@implementation DDView

- (void)loadView {
    self.view = [[DDMessageView alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
