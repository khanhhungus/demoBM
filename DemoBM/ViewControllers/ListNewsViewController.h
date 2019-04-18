//
//  ListNewsViewController.h
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderPublisherView.h"
#import "TitleDescriptionView.h"
#import "Constant.h"
#import "News.h"
#import "FeedSingleImageNewsCell.h"
#import "FeedFourImageNewsCell.h"
#import "FeedArticleNewsCell.h"
#import "FeedDoubleImageNewsCell.h"
#import "FeedTripleImageNewsCell.h"
#import "FormatString.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListNewsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray<News *> *listNews;
@end

NS_ASSUME_NONNULL_END
