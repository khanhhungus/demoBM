//
//  ArticleView.m
//  DemoBM
//
//  Created by CPU11738 on 4/17/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "ArticleView.h"

@implementation ArticleView {
    FormatTime *formatTime;
    FormatString *formatString;
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
    formatString = FormatString.new;
    constant = Constant.new;
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    Theme *theme = appDelegate.currentTheme;
    self.backgroundColor = theme.backgroundColor;
    self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 75)];
    self.thumbnailImageView.image = [UIImage imageNamed: @"grayBackground.png"];
    self.thumbnailImageView.layer.cornerRadius = 5.0;
    self.thumbnailImageView.clipsToBounds = true;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: self.thumbnailImageView];
    
    self.titleLabel = AppLabel.new;
    self.titleLabel.textColor = theme.labelColor;
    self.titleLabel.numberOfLines = 3;
    self.titleLabel.font = [constant fontMedium:14.0f];
    [self addSubview: self.titleLabel];
    
    self.moreInforLabel = AppLabel.new;
    self.moreInforLabel.textColor = theme.secondaryLabelColor;
    self.moreInforLabel.numberOfLines = 1;
    self.moreInforLabel.font = [constant fontNormal:14.0f];
    [self addSubview: self.moreInforLabel];
}

-(void) fillData:(News *) news {
    self.titleLabel.text = news.title;
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.moreInforLabel.text = [NSString stringWithFormat: @"%@ • %@ • %@ bình luận",news.publisher,timeAgo,news.totalComments];
        
    } else {
        self.moreInforLabel.text = [NSString stringWithFormat: @"%@ • %@ bình luận",news.publisher,news.totalComments];
        
    }
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( thumbnailData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [[UIImage alloc] initWithData: thumbnailData];
        });
    });
    float xTitle = 90 + constant.spacing;
    float maxWidthTitle = constant.maxWidth - constant.spacing - 90;
    float heightTitle = [formatString heightForString:news.title font:[constant fontMedium:14] maxWidth:maxWidthTitle];
    
    float heightTitleMax = [constant heightForOneLine:[constant fontMedium: 14.0f]] * 3;
    if (heightTitle > heightTitleMax){
        heightTitle = heightTitleMax;
    }
    
    [self.titleLabel setFrame:CGRectMake(xTitle, 0, maxWidthTitle, heightTitle)];
    
    float yInforLabel = 75 - [constant heightForOneLine:[constant fontNormal: 14.0f]];
    [self.moreInforLabel setFrame:CGRectMake(xTitle, yInforLabel, maxWidthTitle, [constant heightForOneLine:[constant fontMedium: 14.0f]])];
}


@end
