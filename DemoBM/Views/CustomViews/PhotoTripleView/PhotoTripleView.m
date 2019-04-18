//
//  PhotoTripleView.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoTripleView.h"

@implementation PhotoTripleView {
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
    
    float widthItem = (constant.maxWidth - constant.spacing)/ 2 ;
    float heightItem = widthItem*1.3;
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, heightItem)];
    self.mainImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.mainImageView.layer.cornerRadius = 5.0;
    self.mainImageView.clipsToBounds = true;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.mainImageView];
    float ySmallPhotos = self.mainImageView.frame.size.height + constant.spacing;

    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ySmallPhotos, widthItem, heightItem)];
    self.leftImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.leftImageView.layer.cornerRadius = 5.0;
    self.leftImageView.clipsToBounds = true;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.leftImageView];
    
    float xRightImage = widthItem + constant.spacing;
    
    

    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, heightItem)];
    self.rightImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.rightImageView.layer.cornerRadius = 5.0;
    self.rightImageView.clipsToBounds = true;
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.rightImageView];
    UIView *blackLayer = [[UIView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, heightItem)];
    blackLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    blackLayer.layer.cornerRadius = 5.0;
    [self addSubview: blackLayer];
    _heightView = constant.spacing + heightItem*2;
    
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
        NSData *thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        NSData *leftImageData;
        NSData *rightImageData;
        if (news.images[0].url != nil) {
            leftImageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.images[0].url]];
        }
        if (news.images[1].url != nil) {
            rightImageData =  [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.images[1].url]];
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
            
            if (rightImageData) {
                self.rightImageView.image = [[UIImage alloc] initWithData:rightImageData];
            }
        });
        
        
    });
}

@end
