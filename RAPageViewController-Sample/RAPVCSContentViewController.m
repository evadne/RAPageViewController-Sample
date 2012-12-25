//
//  RAPVCSPageViewController.m
//  RAPageViewController-Sample
//
//  Created by Evadne Wu on 7/15/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAPVCSContentViewController.h"

@implementation RAPVCSContentViewController

- (void) viewDidLoad {

	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	self.view.layer.borderColor = [UIColor colorWithRed:((float)(arc4random() % 256))/256.0f green:((float)(arc4random() % 256))/256.0f blue:((float)(arc4random() % 256))/256.0f alpha:1.0f].CGColor;
	self.view.layer.borderWidth = 16.0f;

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}

@end
