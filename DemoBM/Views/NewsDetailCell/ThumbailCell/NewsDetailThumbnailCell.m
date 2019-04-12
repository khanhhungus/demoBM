//
//  NewsDetailThumbnailCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailThumbnailCell.h"

@implementation NewsDetailThumbnailCell {
    float margin;
    float maxWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        margin = 15;
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        maxWidth = widthScreen - margin*2;
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 0, maxWidth, 190)];
        self.thumbnailImageView.layer.cornerRadius = 5.0;
        self.thumbnailImageView.clipsToBounds = true;
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.thumbnailImageView];
    }
    return self;
}
- (void) fillData: (News *)news {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [UIImage imageWithData: data];
        });
    });
}


@end
