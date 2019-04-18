//
//  PhotoDoubleView.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoDoubleView.h"

@implementation PhotoDoubleView {
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
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthItem, heightItem)];
//    self.leftImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.leftImageView.layer.cornerRadius = 5.0;
    self.leftImageView.clipsToBounds = true;
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.leftImageView];
    
    float xRightImage = widthItem + constant.spacing;
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xRightImage, 0, widthItem, heightItem)];
//    self.rightImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.rightImageView.layer.cornerRadius = 5.0;
    self.rightImageView.clipsToBounds = true;
    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.rightImageView];
    
    _heightView = heightItem;

}
- (void) fillData: (News*) news {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:news.avatarURL] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:news.images[0].url] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
}



@end
