//
//  NewsDetailHeaderCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "News.h"
#import "AppDelegate.h"
#import "AppLabel.h"
#import "Constant.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailHeaderCell : UITableViewCell

@property (strong, nonatomic) AppLabel *titleLabel;
- (void) fillData: (News *)news :(float )cellHeight;
@end

NS_ASSUME_NONNULL_END
