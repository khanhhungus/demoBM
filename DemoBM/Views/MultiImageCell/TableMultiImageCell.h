//
//  TableMultiImageCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/10/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "FormatString.h"
#import "FormatTime.h"
#import "AppLabel.h"
#import "AppSubLabel.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "Theme.h"

NS_ASSUME_NONNULL_BEGIN
@interface TableMultiImageCell : UITableViewCell
@property (nonatomic, strong) AppLabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) AppSubLabel *sourceLabel;
@property float heightCell;

- (void)fillData:(News*) news;
@end

NS_ASSUME_NONNULL_END
