//
//  RAPVCSNavigationController.m
//  RAPageViewController-Sample
//
//  Created by Evadne Wu on 12/27/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAPVCSNavigationController.h"

@implementation RAPVCSNavigationController

- (void) viewDidLoad {
	
	[super viewDidLoad];
	
	self.view.clipsToBounds = NO;
	
}

- (void) viewDidLayoutSubviews {

	[super viewDidLayoutSubviews];
	self.topViewController.view.superview.clipsToBounds = NO;
	self.topViewController.view.superview.superview.clipsToBounds = NO;

}

@end
