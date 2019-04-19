//
//  HeaderPublisherView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "HeaderPublisherView.h"

@implementation HeaderPublisherView {
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
-(void) initLayout {
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    Theme *theme = appDelegate.currentTheme;
    self.backgroundColor = theme.backgroundColor;
    constant = Constant.new;
    self.publisherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    self.publisherImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    [self addSubview: self.publisherImageView];
    
    float xPublisherLabel = constant.spacing + self.publisherImageView.frame.size.width ;
    self.publisherLabel = [[AppLabel alloc] initWithFrame: CGRectMake(xPublisherLabel, 0, constant.maxWidth - xPublisherLabel, 18)];
    self.publisherLabel.numberOfLines = 1;
    self.publisherLabel.textColor = theme.labelColor;
    self.publisherLabel.font = [constant fontMedium:16.0f];
    [self addSubview: self.publisherLabel];
    
    self.timeLabel = [[AppLabel alloc] initWithFrame: CGRectMake(xPublisherLabel,18, constant.maxWidth - xPublisherLabel, 15)];
    self.timeLabel.numberOfLines = 1;
    self.timeLabel.textColor = theme.secondaryLabelColor;
    self.timeLabel.font = [constant fontNormal:12.0f];
    [self addSubview: self.timeLabel];
}


-(void) fillData:(News *)news {
    self.publisherLabel.text = [NSString stringWithFormat: @"%@",news.publisher];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * publisherIconData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.publisherIcon]];
        if ( publisherIconData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publisherImageView.image = [[UIImage alloc] initWithData: publisherIconData];
        });
    });
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.timeLabel.text = [NSString stringWithFormat: @"%@",timeAgo];
    }
}


@end
