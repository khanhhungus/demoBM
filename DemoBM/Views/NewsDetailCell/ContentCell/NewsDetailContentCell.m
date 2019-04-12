//
//  NewsDetailContentCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailContentCell.h"

@implementation NewsDetailContentCell {
    float margin;
    float maxWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        margin = 15;
        maxWidth = widthScreen - margin*2;
        self.contentLabel = [[UILabel alloc] initWithFrame: CGRectMake(margin, 0, maxWidth, 100)];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
        [self addSubview: self.contentLabel];
    }
    return self;
}

- (void) fillData: (News *)news :(float )cellHeight {
    self.contentLabel.text = news.content;
    [[self contentLabel] setFrame:CGRectMake(margin, 0, maxWidth, cellHeight)];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
