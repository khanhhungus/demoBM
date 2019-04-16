//
//  FBNewsCell.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/15/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Constant.h"
#import "FormatString.h"
#import "FormatTime.h"
#import "AppLabel.h"
#import "Theme.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface FBNewsCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) AppLabel *titleLabel;
@property (strong, nonatomic) AppLabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *publisherImageView;
@property (strong, nonatomic) AppLabel *publisherLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *totalCmtLabel;

- (void)fillData:(News *)news ;

@end

NS_ASSUME_NONNULL_END
