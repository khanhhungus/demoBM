//
//  CollectionViewController.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "FeedSingleImageNewsCell.h"
#import "FeedFourImageNewsCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(strong, nonatomic)NSMutableArray *arrayNews;

@end

NS_ASSUME_NONNULL_END
