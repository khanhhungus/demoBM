//
//  PhotoFiveView.h
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theme.h"
#import "AppDelegate.h"
#import "Constant.h"
#import "News.h"
#import "AppView.h"
#import <SDWebImage/SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoFiveView : UIView
@property (strong, nonatomic) UIImageView *largeLeftImageView;
@property (strong, nonatomic) UIImageView *largeRightImageView;
@property (strong, nonatomic) UIImageView *smallLeftImageView;
@property (strong, nonatomic) UIImageView *smallCenterImageView;
@property (strong, nonatomic) UIImageView *smallRightImageView;
@property (strong, nonatomic) UILabel *numberOfPhotoNotShow;
-(void)fillData:(News *)news;
@property float heightView;

@end

NS_ASSUME_NONNULL_END
