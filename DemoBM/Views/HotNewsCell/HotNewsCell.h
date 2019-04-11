//
//  HotNewsCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "FormatTime.h"
@protocol HotNewsCellDelegate <NSObject>
@optional
- (void)dataFillSuccess:(NSIndexPath *_Nonnull)indexPath;
@end

NS_ASSUME_NONNULL_BEGIN

@interface HotNewsCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) NSIndexPath *indexPath;

@property float heightCell;
@property float maxWidth;
@property (nonatomic, weak) id <HotNewsCellDelegate> delegate;

- (void)fillData: (News *)news;
@end

NS_ASSUME_NONNULL_END
