//
//  FeedArticleNewsCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderPublisherView.h"
#import "TitleDescriptionView.h"
#import "FeedSingleImageNewsCell.h"
#import "FooterNewsView.h"
#import "ArticleView.h"
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedArticleNewsCell : UITableViewCell
-(void) fillData:(News *)news;

@end

NS_ASSUME_NONNULL_END
