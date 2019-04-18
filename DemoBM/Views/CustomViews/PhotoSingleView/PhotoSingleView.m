//
//  PhotoSingleView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "PhotoSingleView.h"

@implementation PhotoSingleView{
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

- (void) initLayout {
    constant = Constant.new;
    float heightLargeItem = constant.maxWidth*0.6;
    self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, heightLargeItem)];
    self.thumbnailImageView.layer.cornerRadius = 5.0;
    self.thumbnailImageView.clipsToBounds = true;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.thumbnailImageView];
}

- (void)fillData:(News *)news {
    [self.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:news.avatarURL] placeholderImage:[UIImage imageNamed:@"grayBackground.png"]];
}
@end
