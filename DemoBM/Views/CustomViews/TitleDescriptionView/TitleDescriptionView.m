//
//  TitleDescriptionView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "TitleDescriptionView.h"

@implementation TitleDescriptionView {
    Constant *constant;
    FormatString *formatString;
    CGRect viewRect;
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
    formatString = FormatString.new;
    constant = Constant.new;
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    Theme *theme = appDelegate.currentTheme;
    self.backgroundColor = theme.backgroundColor;

    self.titleLabel = [[AppLabel alloc] initWithFrame: CGRectMake(0, 0, viewRect.size.width, 10)];
    self.titleLabel.textColor = theme.labelColor;
    self.titleLabel.numberOfLines = 3;
    self.titleLabel.font = [constant fontMedium:16.0f];
    [self addSubview: self.titleLabel];
    
    self.descriptionLabel = [[AppLabel alloc] initWithFrame: CGRectMake(0, 0, viewRect.size.width, 0)];
    self.descriptionLabel.numberOfLines = 3;
    self.descriptionLabel.textColor = theme.secondaryLabelColor;
    self.descriptionLabel.font = [constant fontNormal:14.0f];
    [self addSubview: self.descriptionLabel];
}

- (void) fillData:(News *)news {
    formatString = FormatString.new;
    constant = Constant.new;
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.desc;
    
    float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
    [self.titleLabel setFrame:CGRectMake(0, 0, constant.maxWidth, heightTitle)];
    float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
    float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
    if (heightDescription > heightDescMax){
        heightDescription = heightDescMax;
    }
    NSLog(@"%@",NSStringFromCGRect(self.titleLabel.frame));
    float yDesc = heightTitle + constant.spacing;
    [self.descriptionLabel setFrame:CGRectMake(0, yDesc, constant.maxWidth, heightDescription)];
}

@end
