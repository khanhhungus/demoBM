//
//  NewsDetailCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "FormatTime.h"

@protocol NewsDetailCellDelegate <NSObject>
@optional
- (void)dataFillSuccess:(NSIndexPath *_Nonnull)indexPath;
@end
NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *sourceLabel;
@property (strong, nonatomic) UIImageView *iconPublisherImageView;
@property float heightCell;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, weak) id <NewsDetailCellDelegate> delegate;
- (void) fillData: (News *)news;
@end

NS_ASSUME_NONNULL_END
