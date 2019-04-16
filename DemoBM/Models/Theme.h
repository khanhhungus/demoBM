//
//  Theme.h
//  DemoBM
//
//  Created by CPU11738 on 4/16/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Theme : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *labelColor;
@property (strong, nonatomic) UIColor *secondaryLabelColor;
@property (strong, nonatomic) UIColor *navigationBarColor;
@property (nonatomic) UIBarStyle barStyle;



@end

NS_ASSUME_NONNULL_END
