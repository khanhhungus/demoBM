//
//  NewsDetailPublisherCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "FormatTime.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailPublisherCell : UITableViewCell
@property (strong, nonatomic) UILabel *publisherLabel;
@property (strong, nonatomic) UIImageView *iconPublisherImageView;
@property float margin;
@property float maxWidth;
- (void) fillData: (News *)news;
@end

NS_ASSUME_NONNULL_END
