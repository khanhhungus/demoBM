//
//  AppDelegate.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "AppLabel.h"
#import "AppSubLabel.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Theme *currentTheme;
@property (strong, nonatomic) Theme *lightTheme;
@property (strong, nonatomic) Theme *darkTheme;

@end

