//
//  IRPVCSViewController.m
//  IRPageViewController-Sample
//
//  Created by Evadne Wu on 7/15/12.
//  Copyright (c) 2012 Iridia Productions. All rights reserved.
//

#import "IRPVCSViewController.h"
#import "IRPVCSPageViewController.h"
#import "IRPageViewControllerSubclass.h"


@interface IRPVCSViewController () <IRPageViewControllerDelegate>

@property (nonatomic, readonly, strong) NSArray *servedViewControllers;

@end


@implementation IRPVCSViewController
@synthesize servedViewControllers = _servedViewControllers;

- (void) viewDidLoad {

	[super viewDidLoad];

	self.delegate = self;
	self.viewControllers = [NSArray arrayWithObject:[self.servedViewControllers objectAtIndex:5]];
	self.scrollView.frame = CGRectInset(self.scrollView.frame, -20.0f, 0.0f);
	
}

- (CGRect) viewRectForPageRect:(CGRect)rect {

	return CGRectInset(rect, 20.0f, 0.0f);

}

- (NSArray *) servedViewControllers {

	if (!_servedViewControllers) {
	
		_servedViewControllers = [NSArray arrayWithObjects:
		
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
			[self newPageViewController],
		
		nil];
	
	}
	
	return _servedViewControllers;

}

- (UIViewController *) newPageViewController {

	IRPVCSPageViewController *pvcsPVC = [[IRPVCSPageViewController alloc] initWithNibName:nil bundle:nil];
	return pvcsPVC;

}

- (UIViewController *) pageViewController:(IRPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc {

	NSArray *allVCs = self.servedViewControllers;
	NSUInteger index = [allVCs indexOfObject:vc];
	
	if ((index == NSNotFound) || (index == 0))
		return nil;

	return [allVCs objectAtIndex:(index - 1)];

}

- (UIViewController *) pageViewController:(IRPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc {

	NSArray *allVCs = self.servedViewControllers;
	NSUInteger index = [allVCs indexOfObject:vc];
	
	if ((index == NSNotFound) || (index == ([allVCs count] - 1)))
		return nil;

	return [allVCs objectAtIndex:(index + 1)];
	
}

@end
