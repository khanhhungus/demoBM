//
//  NewsDetailContentCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailContentCell : UITableViewCell
@property (strong, nonatomic) UILabel *contentLabel;
- (void) fillData: (News *)news :(float )cellHeight;
@end

NS_ASSUME_NONNULL_END
