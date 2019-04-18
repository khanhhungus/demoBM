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
    
    self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, constant.maxWidth, 190)];
    self.thumbnailImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.thumbnailImageView.layer.cornerRadius = 5.0;
    self.thumbnailImageView.clipsToBounds = true;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.thumbnailImageView];
}

- (void)fillData:(News *)news {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( thumbnailData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [[UIImage alloc] initWithData: thumbnailData];
        });
    });
}
@end
