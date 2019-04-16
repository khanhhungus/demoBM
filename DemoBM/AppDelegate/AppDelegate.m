//
//  AppDelegate.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end


@implementation AppDelegate
//    Theme *lightTheme;
//    Theme *darkTheme;
//}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _currentTheme = Theme.new;
    _lightTheme = Theme.new;
    _darkTheme = Theme.new;
    
    [_lightTheme setBackgroundColor: [UIColor whiteColor]];
    [_lightTheme setLabelColor: [UIColor blackColor]];
    [_lightTheme setSecondaryLabelColor:[UIColor darkGrayColor]];
    [_lightTheme setNavigationBarColor:[UIColor whiteColor]];
    [_lightTheme setBarStyle: UIBarStyleDefault];
    
    [_darkTheme setBackgroundColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    [_darkTheme setLabelColor: [UIColor whiteColor]];
    [_darkTheme setSecondaryLabelColor:[UIColor lightGrayColor]];
    [_darkTheme setBarStyle:UIBarStyleBlack];
    [_darkTheme setNavigationBarColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];

    _currentTheme = _lightTheme;
    
//    [AppLabel.appearance setTextColor: _currentTheme.labelColor];
//    [AppSubLabel.appearance setTextColor: _currentTheme.secondaryLabelColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTheme:)
                                                 name:@"ChangeTheme" object:nil];
    
    return YES;
}


- (void)changeTheme:(NSNotification *)note {
    if (_currentTheme == _lightTheme) {
        _currentTheme = _darkTheme;
        NSLog(@"_darkTheme");
    } else {
        _currentTheme = _lightTheme;
        NSLog(@"_lightTheme"); 

    }
    
    [UITableView.appearance setBackgroundColor: _currentTheme.backgroundColor];
    [UITableViewCell.appearance setBackgroundColor: _currentTheme.backgroundColor];

    [AppLabel.appearance customColor:_currentTheme.labelColor];
    [AppSubLabel.appearance setTextColor:_currentTheme.secondaryLabelColor];
    [UINavigationBar.appearance setBarStyle:_currentTheme.barStyle];
    [UINavigationBar.appearance setBarTintColor: _currentTheme.backgroundColor];
    [UINavigationBar.appearance setBackgroundColor:_currentTheme.backgroundColor];
    [UINavigationBar.appearance setTranslucent:NO];
    
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        for (UIView *view in window.subviews) {
            [view removeFromSuperview];
            [window addSubview:view];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
