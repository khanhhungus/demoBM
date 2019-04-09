//
//  CollectionViewCell.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property(strong, nonatomic) IBOutlet UIImageView *thumbnail;
@property(strong, nonatomic) IBOutlet UILabel *title;
@property(strong, nonatomic) IBOutlet UILabel *source;

- (void)fillData:(News*) news;

@end

NS_ASSUME_NONNULL_END
