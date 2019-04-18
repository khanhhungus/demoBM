//
//  ContainerPageViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "ContainerPageViewController.h"

@interface ContainerPageViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) NSArray *array;

@end

@implementation ContainerPageViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super init]
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        //[[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor blackColor]];
        //[[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
        [self.view setBackgroundColor:[UIColor redColor]];
        
        self.array = @[
                       @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                       @"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                       @"Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                       @"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                       ];
        
        ImagePageViewController *initialViewController = [self viewControllerWithPageIndex:0];
        [self setViewControllers:@[initialViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    return self;
}

#pragma mark - Custom methods

- (UIViewController *)viewControllerWithPageIndex:(NSInteger)pageIndex {
    if (pageIndex < 0 || pageIndex >= [self.array count]) {
        return nil;
    }
    ImagePageViewController *viewController = ImagePageViewController.new;
    viewController.text = self.array[pageIndex];
    viewController.pageIndex = pageIndex;
    
    return viewController;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ImagePageViewController *vc = (ImagePageViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index + 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ImagePageViewController *vc = (ImagePageViewController *)viewController;
    NSUInteger index = vc.pageIndex;
    return [self viewControllerWithPageIndex:(index - 1)];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.array.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [(ImagePageViewController *)pageViewController.presentedViewController pageIndex];
}

@end
