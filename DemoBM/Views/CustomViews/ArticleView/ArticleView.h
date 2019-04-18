//
//  ArticleView.h
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
#import "FormatTime.h"
#import "AppView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ArticleView : AppView
@property (strong, nonatomic) AppLabel *titleLabel;
@property (strong, nonatomic) AppLabel *moreInforLabel;
@property (strong, nonatomic) UIImageView *thumbnailImageView;
-(void) fillData:(News *) news;
@end

NS_ASSUME_NONNULL_END
