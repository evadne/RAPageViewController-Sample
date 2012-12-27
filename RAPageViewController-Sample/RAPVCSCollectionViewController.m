//
//  RAPVCSCollectionViewController.m
//  RAPageViewController-Sample
//
//  Created by Evadne Wu on 12/24/12.
//  Copyright (c) 2012 Radius. All rights reserved.
//

#import "RAPVCSCollectionViewController.h"
#import "RAPVCSContentViewController.h"

@interface RAPVCSCollectionViewController () <RAPageCollectionViewControllerDelegate>
@property (nonatomic, readonly, strong) NSMutableArray *viewControllers;
@end

@implementation RAPVCSCollectionViewController
@synthesize viewControllers = _viewControllers;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (!self)
		return nil;
	
	self.title = @"Page Collection";
	self.delegate = self;
	
	UIBarButtonItem * (^item)(UIBarButtonSystemItem, id, SEL) = ^ (UIBarButtonSystemItem systemItem, id target, SEL action) {
		
		return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:target action:action];
		
	};
	
	self.toolbarItems = @[
		item(UIBarButtonSystemItemRewind, self, @selector(handleRewind:)),
		item(UIBarButtonSystemItemFlexibleSpace, nil, nil),
		item(UIBarButtonSystemItemAdd, self, @selector(handleBackwardAdd:)),
		item(UIBarButtonSystemItemFlexibleSpace, nil, nil),
		item(UIBarButtonSystemItemTrash, self, @selector(handleTrash:)),
		item(UIBarButtonSystemItemFlexibleSpace, nil, nil),
		item(UIBarButtonSystemItemAdd, self, @selector(handleForwardAdd:)),
		item(UIBarButtonSystemItemFlexibleSpace, nil, nil),
		item(UIBarButtonSystemItemFastForward, self, @selector(handleFastForward:))
	];
	
	return self;

}

- (void) viewDidLoad {
	
	[super viewDidLoad];
	
	self.collectionView.clipsToBounds = NO;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.alwaysBounceHorizontal = YES;
	self.collectionView.alwaysBounceVertical = NO;
	self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	self.collectionViewLayout.minimumLineSpacing = 16.0f;

}

- (NSUInteger) numberOfViewControllersInPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {

	return [self.viewControllers count];

}

- (UIViewController *) viewControllerForPageAtIndex:(NSUInteger)index inPageCollectionViewController:(RAPageCollectionViewController *)pageCollectionViewController {
	
	return self.viewControllers[index];

}

- (NSMutableArray *) viewControllers {

	if (!_viewControllers) {
	
		_viewControllers = [@[
		
			[self newContentViewController],
			[self newContentViewController],
			[self newContentViewController],
			[self newContentViewController],
			[self newContentViewController]
		
		] mutableCopy];
	
	}
	
	return _viewControllers;

}

- (void) viewWillAppear:(BOOL)animated {

	[super viewWillAppear:animated];
	
	[self.navigationController setToolbarHidden:NO animated:animated];

}

- (UIViewController *) newContentViewController {

	RAPVCSContentViewController *pvcsPVC = [[RAPVCSContentViewController alloc] initWithNibName:nil bundle:nil];
	return pvcsPVC;

}

- (void) handleRewind:(id)sender {

	[self setDisplayIndex:0.0f animated:YES completion:nil];

}

- (void) handleBackwardAdd:(id)sender {
	
	CGFloat displayIndex = self.displayIndex;
	NSUInteger viewControllerIndex = isnan(displayIndex) ?
		0 :
		(NSUInteger)roundf(displayIndex);
	
	[self.collectionView performBatchUpdates:^{
		
		[self.viewControllers insertObject:[self newContentViewController] atIndex:viewControllerIndex];
		
		[self.collectionView insertItemsAtIndexPaths:@[
			[NSIndexPath indexPathForItem:viewControllerIndex inSection:0]
		]];
		
		[self setDisplayIndex:(CGFloat)viewControllerIndex animated:YES completion:nil];
		
	} completion:nil];
	
}

- (void) handleTrash:(id)sender {
	
	CGFloat displayIndex = self.displayIndex;
	if (isnan(displayIndex))
		return;
	
	NSUInteger viewControllerIndex = (NSUInteger)roundf(displayIndex);
	
	[self.collectionView performBatchUpdates:^{
		
		[self.viewControllers removeObjectAtIndex:viewControllerIndex];
		
		[self.collectionView deleteItemsAtIndexPaths:@[
			[NSIndexPath indexPathForItem:viewControllerIndex inSection:0]
		]];
		
	} completion:nil];

}

- (void) handleForwardAdd:(id)sender {

	CGFloat displayIndex = self.displayIndex;
	NSUInteger viewControllerIndex = isnan(displayIndex) ?
		0 :
		(NSUInteger)roundf(displayIndex) + 1;
	
	[self.collectionView performBatchUpdates:^{
		
		[self.viewControllers insertObject:[self newContentViewController] atIndex:viewControllerIndex];
		
		[self.collectionView insertItemsAtIndexPaths:@[
			[NSIndexPath indexPathForItem:viewControllerIndex inSection:0]
		]];
		
		[self setDisplayIndex:(CGFloat)viewControllerIndex animated:YES completion:nil];
		
	} completion:nil];
	
}

- (void) handleFastForward:(id)sender {

	[self setDisplayIndex:((CGFloat)[self.viewControllers count] - 1.0f) animated:YES completion:nil];

}

@end
