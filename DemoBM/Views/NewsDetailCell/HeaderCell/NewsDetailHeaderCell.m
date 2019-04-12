//
//  NewsDetailHeaderCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailHeaderCell.h"

@implementation NewsDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;

        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        self.margin = 15;
        self.maxWidth = widthScreen - self.margin*2;
        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.margin, 0, self.maxWidth, 100)];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:26.0f];
        [self addSubview: self.titleLabel];
    }
    return self;
}

- (void) fillData: (News *)news :(float )cellHeight {
    self.titleLabel.text = news.title;
    [[self titleLabel] setFrame:CGRectMake(_margin, 0, _maxWidth, cellHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
