//
//  CustomCell.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/8/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "CustomCell.h"


@interface CustomCell ()

@end
@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)fillData:(News*) news {
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];

    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.source.text = [NSString stringWithFormat: @"%@ • %@ • %@ bình luận",news.publisher,timeAgo,news.totalComments];

    } else {
        self.source.text = [NSString stringWithFormat: @"%@ • %@ bình luận",news.publisher,news.totalComments];

    }
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    Theme *theme = appDelegate.currentTheme;
    self.title.text = news.title;
    self.title.textColor = theme.labelColor;

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
