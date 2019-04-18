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
    self.mainImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.mainImageView.layer.cornerRadius = 5.0;
    self.mainImageView.clipsToBounds = true;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.mainImageView];
    
    float ySmallPhotos = self.mainImageView.frame.size.height + constant.spacing;
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ySmallPhotos, widthItem, widthItem)];
    self.leftImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.leftImageView.layer.cornerRadius = 5.0;
    self.leftImageView.clipsToBounds = true;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.leftImageView];

    float xCenterImage = widthItem + constant.spacing;
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xCenterImage, ySmallPhotos, widthItem, widthItem)];
    self.centerImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.centerImageView.layer.cornerRadius = 5.0;
    self.centerImageView.clipsToBounds = true;
    self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.centerImageView];


    float xRightImage = widthItem*2 + constant.spacing*2;

    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, widthItem)];
    self.rightImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.rightImageView.layer.cornerRadius = 5.0;
    self.rightImageView.clipsToBounds = true;
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.rightImageView];

    _heightView = 190 + constant.spacing + widthItem;
    
    _numberOfPhotoNotShow = UILabel.new;
    float xNumberOfPhotoLabel = self.rightImageView.center.x - 20;
    float yNumberOfPhotoLabel = self.rightImageView.center.y - 20;
    
    [_numberOfPhotoNotShow setFrame: CGRectMake(xNumberOfPhotoLabel, yNumberOfPhotoLabel, 40, 40)];
    _numberOfPhotoNotShow.text = @"+14";
    _numberOfPhotoNotShow.textColor = UIColor.whiteColor;
    _numberOfPhotoNotShow.font = [constant fontMedium:22];
    [self addSubview:_numberOfPhotoNotShow];
}
- (void) fillData: (News*) news {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        NSData *leftImageData;
        NSData * centerImageData;
        NSData * rightImageData;
        if (news.images[0].url != nil) {
            leftImageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.images[0].url]];
        }
        if (news.images[1].url != nil) {
            centerImageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.images[1].url]];
        }
        if (news.images[2].url != nil) {
            rightImageData =  [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.images[2].url]];
        }
        
        if ( thumbnailData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (thumbnailData) {
                self.mainImageView.image = [[UIImage alloc] initWithData: thumbnailData];
            }
            if (leftImageData) {
                self.leftImageView.image = [[UIImage alloc] initWithData:leftImageData];
            }
            
            if (centerImageData) {
                self.centerImageView.image = [[UIImage alloc] initWithData:centerImageData];
            }
            
            if (rightImageData) {
                self.rightImageView.image = [[UIImage alloc] initWithData:rightImageData];
            }
        });
        
        
    });
}

@end
