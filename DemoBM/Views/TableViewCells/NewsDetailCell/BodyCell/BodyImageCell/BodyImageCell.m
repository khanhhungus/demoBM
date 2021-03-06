//
//  BodyImageCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "BodyImageCell.h"

@implementation BodyImageCell {
    Constant *constant;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        constant = Constant.new;
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(constant.margin, 0, constant.maxWidth, 190)];
        self.thumbnailImageView.layer.cornerRadius = 5.0;
        self.thumbnailImageView.clipsToBounds = true;
        self.thumbnailImageView.image = [UIImage imageNamed:@"grayBackground.png"];
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.thumbnailImageView];
    }
    return self;
}
- (void) fillData: (Body *)body {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: body.content]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [UIImage imageWithData: data];
        });
    });
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
