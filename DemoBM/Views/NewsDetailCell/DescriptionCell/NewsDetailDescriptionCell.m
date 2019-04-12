//
//  NewsDetailDescriptionCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailDescriptionCell.h"

@implementation NewsDetailDescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        self.margin = 15;
        self.maxWidth = widthScreen - self.margin*2;
        self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.margin, 0, self.maxWidth, 100)];
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:22.0f];
        [self addSubview: self.descriptionLabel];
    }
    return self;
}

- (void) fillData: (News *)news :(float )cellHeight {
    self.descriptionLabel.text = news.desc;
    [[self descriptionLabel] setFrame:CGRectMake(_margin, 0, _maxWidth, cellHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
