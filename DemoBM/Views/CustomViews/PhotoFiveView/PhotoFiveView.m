//
//  PhotoFiveView.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoFiveView.h"

@implementation PhotoFiveView  {
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
    float widthLargeItem = (constant.maxWidth - constant.spacing)/ 2 ;
    float heightLargeItem = widthLargeItem;

    self.largeLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthLargeItem, heightLargeItem)];
    self.largeLeftImageView.layer.cornerRadius = 5.0;
    self.largeLeftImageView.clipsToBounds = true;
    self.largeLeftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.largeLeftImageView];

    
    self.largeRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(widthLargeItem + constant.spacing, 0, constant.maxWidth, heightLargeItem)];
    self.largeRightImageView.layer.cornerRadius = 5.0;
    self.largeRightImageView.clipsToBounds = true;
    self.largeRightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.largeLeftImageView];
    float widthItem = (constant.maxWidth - constant.spacing*2)/ 3 ;
    float heightItem = widthItem*1.3;


    float ySmallPhotos = self.largeLeftImageView.frame.size.height + constant.spacing;
    self.smallLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ySmallPhotos, widthItem, heightItem)];
    self.smallLeftImageView.layer.cornerRadius = 5.0;
    self.smallLeftImageView.clipsToBounds = true;
    self.smallLeftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.smallLeftImageView];
    
    float xCenterImage = widthItem + constant.spacing;
    self.smallCenterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCenterImage, ySmallPhotos, widthItem, heightItem)];
    self.smallCenterImageView.layer.cornerRadius = 5.0;
    self.smallCenterImageView.clipsToBounds = true;
    self.smallCenterImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.smallCenterImageView];
    
    
    float xRightImage = widthItem*2 + constant.spacing*2;
    
    self.smallRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, heightItem)];
    self.smallRightImageView.layer.cornerRadius = 5.0;
    self.smallRightImageView.clipsToBounds = true;
    self.smallRightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.smallRightImageView];
    
    UIView *blackLayer = [[UIView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, widthItem)];
    blackLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    blackLayer.layer.cornerRadius = 5.0;
    [self addSubview: blackLayer];
    
    _heightView = heightLargeItem + constant.spacing + heightItem;
    
    _numberOfPhotoNotShow = UILabel.new;
    float xNumberOfPhotoLabel = self.smallRightImageView.center.x - 20;
    float yNumberOfPhotoLabel = self.smallRightImageView.center.y - 20;
    
    [_numberOfPhotoNotShow setFrame: CGRectMake(xNumberOfPhotoLabel, yNumberOfPhotoLabel, 40, 40)];
//    _numberOfPhotoNotShow.text = @"+14";
    _numberOfPhotoNotShow.textColor = UIColor.whiteColor;
    _numberOfPhotoNotShow.font = [constant fontMedium:22];
    [self addSubview:_numberOfPhotoNotShow];
}
- (void) fillData: (News*) news {
    [self.largeLeftImageView sd_setImageWithURL:[NSURL URLWithString:news.avatarURL] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.largeRightImageView sd_setImageWithURL:[NSURL URLWithString:news.images[0].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.smallLeftImageView sd_setImageWithURL:[NSURL URLWithString:news.images[1].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.smallCenterImageView sd_setImageWithURL:[NSURL URLWithString:news.images[2].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.smallRightImageView sd_setImageWithURL:[NSURL URLWithString:news.images[3].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    
    if (news.images.count > 4) {
        
        _numberOfPhotoNotShow.text = [NSString stringWithFormat: @"+%lu",news.images.count - 5];
    }
}




@end
