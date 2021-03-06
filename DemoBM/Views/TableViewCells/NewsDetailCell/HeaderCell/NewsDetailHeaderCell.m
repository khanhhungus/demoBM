//
//  NewsDetailHeaderCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailHeaderCell.h"

@implementation NewsDetailHeaderCell {
    Constant *constant;
    FormatString *formatString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
        Theme *theme = appDelegate.currentTheme;
        formatString = FormatString.new;
        constant = [[Constant alloc] init ];
        self.titleLabel = AppLabel.new;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = theme.labelColor;
        self.titleLabel.font = [constant fontMedium:26];
        [self addSubview: self.titleLabel];
    }
    return self;
}

- (void) fillData: (News *)news :(float )cellHeight {
    self.titleLabel.text = news.title;
    cellHeight = [formatString heightForString: news.title font:[constant fontMedium:26] maxWidth:constant.maxWidth] ;
    [[self titleLabel] setFrame:CGRectMake(constant.margin, 0, constant.maxWidth, cellHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
