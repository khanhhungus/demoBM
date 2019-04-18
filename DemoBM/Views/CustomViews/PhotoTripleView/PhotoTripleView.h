//
//  PhotoTripleView.h
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

NS_ASSUME_NONNULL_BEGIN

@interface PhotoTripleView : UIView
@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *centerImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UILabel *numberOfPhotoNotShow;
@property float heightView;
-(void)fillData:(News *)news;

@end

NS_ASSUME_NONNULL_END
