//
//  NewsDetailPublisherCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailPublisherCell.h"

@implementation NewsDetailPublisherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        self.margin = 15;
        self.maxWidth = widthScreen - self.margin*2;
        self.iconPublisherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_margin, self.frame.origin.y, 20, 20)];
        self.iconPublisherImageView.image = [UIImage imageNamed: @"thumbnail.png"];
        [self addSubview: self.iconPublisherImageView];
        
        float xPublisherLabel = self.margin * 2 + _iconPublisherImageView.frame.size.width;
        self.publisherLabel = [[UILabel alloc] initWithFrame: CGRectMake(xPublisherLabel, self.frame.origin.y, self.maxWidth - xPublisherLabel, 25)];
        self.publisherLabel.numberOfLines = 1;
        self.publisherLabel.textColor = [UIColor lightGrayColor];
        self.publisherLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self addSubview: self.publisherLabel];
    }
    
    return self;
}
- (void)fillData:(News *)news {
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.publisherLabel.text = [NSString stringWithFormat: @"%@ • %@ • %@ bình luận",news.publisher,timeAgo,news.totalComments];
        
    } else {
        self.publisherLabel.text = [NSString stringWithFormat: @"%@ • %@ bình luận",news.publisher,news.totalComments];
    }
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * iconData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.publisherIcon]];
        if ( iconData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconPublisherImageView.image = [UIImage imageWithData: iconData];
        });
    });
}
@end
