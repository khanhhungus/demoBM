//
//  NewsDetailHeaderCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailHeaderCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property float margin;
@property float maxWidth;
@property float heightCell;
- (void) fillData: (News *)news :(float )cellHeight;
@end

NS_ASSUME_NONNULL_END
