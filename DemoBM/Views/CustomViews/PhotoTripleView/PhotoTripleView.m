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
    float heightLargeItem = constant.maxWidth*0.7;
    float heightItem = widthItem*1.3;
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, heightLargeItem)];
    self.mainImageView.layer.cornerRadius = 5.0;
    self.mainImageView.clipsToBounds = true;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.mainImageView];
    float ySmallPhotos = self.mainImageView.frame.size.height + constant.spacing;

    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ySmallPhotos, widthItem, heightItem)];
    self.leftImageView.layer.cornerRadius = 5.0;
    self.leftImageView.clipsToBounds = true;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.leftImageView];
    
    float xRightImage = widthItem + constant.spacing;

    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, ySmallPhotos, widthItem, heightItem)];
    self.rightImageView.layer.cornerRadius = 5.0;
    self.rightImageView.clipsToBounds = true;
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.rightImageView];

    _heightView = constant.spacing + heightItem + heightLargeItem;
}


- (void) fillData: (News*) news {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:news.avatarURL] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:news.images[0].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
        
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:news.images[1].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    });
}

@end
