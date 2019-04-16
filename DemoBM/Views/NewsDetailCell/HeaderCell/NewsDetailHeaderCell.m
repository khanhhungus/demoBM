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
        constant = [[Constant alloc] init ];
        self.titleLabel = AppLabel.new;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = theme.labelColor;
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:26.0f];
        [self addSubview: self.titleLabel];
    }
    return self;
}

- (void) fillData: (News *)news :(float )cellHeight {
    self.titleLabel.text = news.title;
    [[self titleLabel] setFrame:CGRectMake(constant.margin, 0, constant.maxWidth, cellHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
