//
//  IRPVCSPageViewController.m
//  IRPageViewController-Sample
//
//  Created by Evadne Wu on 7/15/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRPVCSPageViewController.h"

@implementation IRPVCSPageViewController

- (void) viewDidLoad {

	[super viewDidLoad];
	
	self.view.layer.borderColor = [UIColor redColor].CGColor;
	self.view.layer.borderWidth = 2.0f;

}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
	
}

@end
