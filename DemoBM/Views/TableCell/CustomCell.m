//
//  CustomCell.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "CustomCell.h"
#import "News.h"
#import "FormatTime.h"

@interface CustomCell ()

@end
@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)fillData:(News*) news {
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
    NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
    self.title.text = news.title;
    self.source.text = [NSString stringWithFormat: @"%@ • %@ giờ • %@ bình luận",news.publisher, timeAgo,news.totalComments];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnail.image = [UIImage imageWithData: data];
        });
    });
}

@end
