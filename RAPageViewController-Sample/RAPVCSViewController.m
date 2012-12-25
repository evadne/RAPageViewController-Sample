//
//  RAPVCSViewController.m
//  RAPageViewController-Sample
//
//  Created by Evadne Wu on 7/15/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAPVCSViewController.h"
#import "RAPVCSContentViewController.h"
#import "RAPageViewControllerSubclass.h"


@interface RAPVCSViewController () <RAPageViewControllerDelegate>

@property (nonatomic, readonly, strong) NSArray *servedViewControllers;

@end


@implementation RAPVCSViewController
@synthesize servedViewControllers = _servedViewControllers;

- (void) viewDidLoad {

	[super viewDidLoad];

	self.delegate = self;
	self.viewControllers = [NSArray arrayWithObject:[self.servedViewControllers objectAtIndex:MIN([self.servedViewControllers count] - 1, 5)]];
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

	RAPVCSContentViewController *pvcsPVC = [[RAPVCSContentViewController alloc] initWithNibName:nil bundle:nil];
	return pvcsPVC;

}

- (UIViewController *) pageViewController:(RAPageViewController *)pvc viewControllerBeforeViewController:(UIViewController *)vc {

	NSArray *allVCs = self.servedViewControllers;
	NSUInteger index = [allVCs indexOfObject:vc];
	
	if ((index == NSNotFound) || (index == 0))
		return nil;

	UIViewController *viewController = [allVCs objectAtIndex:(index - 1)];
	for (UILabel *label in viewController.view.subviews)
		if ([label isKindOfClass:[UILabel class]])
			label.text = [NSString stringWithFormat:@"%i", [allVCs indexOfObject:viewController]];
	
	return viewController;

}

- (UIViewController *) pageViewController:(RAPageViewController *)pvc viewControllerAfterViewController:(UIViewController *)vc {

	NSArray *allVCs = self.servedViewControllers;
	NSUInteger index = [allVCs indexOfObject:vc];
	
	if ((index == NSNotFound) || (index == ([allVCs count] - 1)))
		return nil;

	UIViewController *viewController = [allVCs objectAtIndex:(index + 1)];
	for (UILabel *label in viewController.view.subviews)
		if ([label isKindOfClass:[UILabel class]])
			label.text = [NSString stringWithFormat:@"%i", [allVCs indexOfObject:viewController]];
	
	return viewController;
	
}

- (UIView *) newPageViewContainer {

	UIView *container = [super newPageViewContainer];
	container.layer.borderColor = [UIColor redColor].CGColor;
	container.layer.borderWidth = 4.0f;
	
	return container;

}

@end
