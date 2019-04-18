//
//  PhotoFourView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoFourView.h"

@implementation PhotoFourView {
    Constant *constant;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void) initLayout {
    constant = Constant.new;
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    Theme *theme = appDelegate.currentTheme;
    self.backgroundColor = theme.backgroundColor;
    float widthItem = (constant.maxWidth - constant.spacing*2)/ 3 ;
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, 190)];
    self.mainImageView.layer.cornerRadius = 5.0;
    self.mainImageView.clipsToBounds = true;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.mainImageView];
    
    float ySmallPhotos = self.mainImageView.frame.size.height + constant.spacing;
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ySmallPhotos, widthItem, widthItem)];
    self.leftImageView.layer.cornerRadius = 5.0;
    self.leftImageView.clipsToBounds = true;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.leftImageView];

    float xCenterImage = widthItem + constant.spacing;
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCenterImage, ySmallPhotos, widthItem, widthItem)];
    self.centerImageView.layer.cornerRadius = 5.0;
    self.centerImageView.clipsToBounds = true;
    self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.centerImageView];


    float xRightImage = widthItem*2 + constant.spacing*2;

    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, widthItem)];
    self.rightImageView.layer.cornerRadius = 5.0;
    self.rightImageView.clipsToBounds = true;
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.rightImageView];
    
    _heightView = 190 + constant.spacing + widthItem;

}
- (void) fillData: (News*) news {
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:news.avatarURL] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:news.images[0].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:news.images[1].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:news.images[2].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
}

@end
