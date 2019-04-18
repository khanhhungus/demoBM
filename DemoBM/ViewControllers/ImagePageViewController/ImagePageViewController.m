//
//  ImagePageViewController.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "ImagePageViewController.h"

@interface ImagePageViewController ()
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ImagePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.text = self.text;
    
    [self.view addSubview:self.textLabel];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textLabel setNumberOfLines:0];
    
    [[self.textLabel.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor] setActive:YES];
    [[self.textLabel.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor] setActive:YES];
    [[self.textLabel.widthAnchor constraintEqualToConstant:300.f] setActive:YES];
    
    self.textLabel.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor yellowColor];
}

@end
