//
//  BodyImageCell.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "FormatString.h"


NS_ASSUME_NONNULL_BEGIN

@interface BodyImageCell : UITableViewCell
@property (strong, nonatomic) UIImageView *thumbnailImageView;
- (void) fillData: (Body *)body;
@end

NS_ASSUME_NONNULL_END
