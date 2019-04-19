//
//  PhotoPageView.h
//  DemoBM
//
//  Created by CPU11738 on 4/19/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Image.h"
#import "Constant.h"
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoPageView : UIView <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;

-(void) fillData:(News *)news ;
@property float heightView;
    

@end

NS_ASSUME_NONNULL_END
