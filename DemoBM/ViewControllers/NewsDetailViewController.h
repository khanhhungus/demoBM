//
//  NewsDetailViewController.h
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "NewsDetailHeaderCell.h"
#import "NewsDetailPublisherCell.h"
#import "NewsDetailDescriptionCell.h"
#import "NewsDetailContentCell.h"
#import "NewsDetailThumbnailCell.h"
#import "CustomCell.h"
#import "FormatString.h"
#import "DataSource.h"
#import "BodyTextCell.h"
#import "BodyImageCell.h"
#import "AppDelegate.h"
#import "Theme.h"
#import "Constant.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) News *news;
@property (strong, nonatomic) NSMutableArray<News *> *relatedNewsArray;
@end

NS_ASSUME_NONNULL_END
