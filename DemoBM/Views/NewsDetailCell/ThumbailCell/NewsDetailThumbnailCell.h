//
//  NewsDetailThumbnailCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailThumbnailCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailImageView;
- (void) fillData: (News *)news;
@end

NS_ASSUME_NONNULL_END
