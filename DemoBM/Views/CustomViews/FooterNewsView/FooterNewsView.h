//
//  FooterNewsView.h
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "FormatString.h"
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface FooterNewsView : UIView
@property (strong, nonatomic) UILabel *totalCmtLabel;
-(void)fillData:(News *)news;
@end

NS_ASSUME_NONNULL_END
