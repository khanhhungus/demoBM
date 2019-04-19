//
//  FooterNewsView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "FooterNewsView.h"

@implementation FooterNewsView {
    Constant *constant;
    FormatString *formatString;
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

    float heightOneLine = [constant heightForOneLine: [constant fontNormal:14]];
    self.totalCmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(constant.margin, 0, constant.maxWidth, heightOneLine)];
    self.totalCmtLabel.font = [constant fontNormal:14.0f];
    self.totalCmtLabel.textColor = theme.secondaryLabelColor;
    [self addSubview: self.totalCmtLabel];
}

-(void)fillData:(News *)news {
    NSString *totalCmt = [NSString stringWithFormat:@"%@ bình luận",news.totalComments];
    self.totalCmtLabel.text = totalCmt;
    float widthCmtLb = [formatString widthForString: totalCmt font: [constant fontNormal:14.0f]];
    float xTotalCmt = constant.maxWidth - widthCmtLb;
    [self.totalCmtLabel setFrame: CGRectMake(xTotalCmt, 0, widthCmtLb, self.totalCmtLabel.frame.size.height)];
}
@end
