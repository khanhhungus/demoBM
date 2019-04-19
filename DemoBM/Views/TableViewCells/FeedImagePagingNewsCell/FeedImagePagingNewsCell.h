//
//  FeedImagePagingNewsCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/19/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderPublisherView.h"
#import "TitleDescriptionView.h"
#import "PhotoSingleView.h"
#import "FeedSingleImageNewsCell.h"
#import "FooterNewsView.h"
#import "PhotoFourView.h"
#import "News.h"
#import "PhotoPageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedImagePagingNewsCell : UITableViewCell
-(void) fillData:(News *)news;

@end

NS_ASSUME_NONNULL_END
