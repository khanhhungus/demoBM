//
//  HeaderPublisherView.h
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppLabel.h"
#import "Theme.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "News.h"
#import "FormatTime.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeaderPublisherView : UIView
@property (strong, nonatomic) UIImageView *publisherImageView;
@property (strong, nonatomic) AppLabel *publisherLabel;
@property (strong, nonatomic) UILabel *timeLabel;

-(void) fillData:(News *)news;
@end

NS_ASSUME_NONNULL_END
