//
//  NewsDetailViewController.h
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsDetailCell.h"
#import "NewsDetailHeaderCell.h"
#import "NewsDetailPublisherCell.h"
#import "NewsDetailDescriptionCell.h"
#import "FormatString.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NewsDetailCellDelegate>

@property (strong, nonatomic) News *news;
@end

NS_ASSUME_NONNULL_END
