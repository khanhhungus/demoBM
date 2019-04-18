//
//  PhotoDoubleView.h
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "AppView.h"
#import "Theme.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoDoubleView : AppView
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
- (void) fillData: (News*) news;
@property float heightView;
@end

NS_ASSUME_NONNULL_END
