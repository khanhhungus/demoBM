//
//  FBNewsCell.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/15/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "FBNewsCell.h"

@implementation FBNewsCell {
    FormatString *formatString;
    Constant *constant;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        formatString = [[FormatString alloc] init];
        constant = [[Constant alloc] init];
        AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
        Theme *theme = appDelegate.currentTheme;
        self.publisherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(constant.margin, 0, 35, 35)];
        self.publisherImageView.image = [UIImage imageNamed: @"grayBackground.png"];
        [self addSubview: self.publisherImageView];
        
        float xPublisherLabel = constant.margin * 2 + self.publisherImageView.frame.size.width;
        self.publisherLabel = [[AppLabel alloc] initWithFrame: CGRectMake(xPublisherLabel, 0, constant.maxWidth - xPublisherLabel, 18)];
        self.publisherLabel.numberOfLines = 1;
        self.publisherLabel.textColor = theme.labelColor;
        self.publisherLabel.font = [constant fontMedium:16.0f];
        [self addSubview: self.publisherLabel];

        self.timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(xPublisherLabel, 18, constant.maxWidth - xPublisherLabel, 18)];
        self.timeLabel.numberOfLines = 1;
        self.timeLabel.textColor = [UIColor grayColor];
        self.timeLabel.font = [constant fontNormal:12.0f];
        [self addSubview: self.timeLabel];
        
        self.titleLabel = [[AppLabel alloc] initWithFrame: CGRectMake(constant.margin, 0, constant.maxWidth, 100)];
//        self.titleLabel = AppLabel.new;
        self.titleLabel.textColor = theme.labelColor;
        self.titleLabel.numberOfLines = 3;
        self.titleLabel.font = [constant fontMedium:16.0f];
        [self addSubview: self.titleLabel];
        
        self.descriptionLabel = [[AppLabel alloc] initWithFrame: CGRectMake(constant.margin, 0, constant.maxWidth, 0)];
        self.descriptionLabel.numberOfLines = 3;
        self.descriptionLabel.textColor = theme.secondaryLabelColor;
        self.descriptionLabel.font = [constant fontNormal:14.0f];
        [self addSubview: self.descriptionLabel];
        
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 190)];
        self.thumbnailImageView.image = [UIImage imageNamed: @"grayBackground.png"];
        self.thumbnailImageView.layer.cornerRadius = 5.0;
        self.thumbnailImageView.clipsToBounds = true;
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.thumbnailImageView];
        
        self.totalCmtLabel = [[UILabel alloc] init];
        self.totalCmtLabel.font = [constant fontNormal:14.0f];
        self.totalCmtLabel.textColor = [UIColor lightGrayColor];
        [self addSubview: self.totalCmtLabel];
        
    }
    return self;
}

- (void) fillData:(News *)news {
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.desc;
    self.publisherLabel.text = [NSString stringWithFormat: @"%@",news.publisher];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * publisherIconData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.publisherIcon]];
        NSData * thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];

        if ( publisherIconData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.publisherImageView.image = [UIImage imageWithData: publisherIconData];
        });
        if ( thumbnailData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [UIImage imageWithData: thumbnailData];
        });
        

    });
    self.totalCmtLabel.text = [NSString stringWithFormat: @"%@ bình luận",news.totalComments];

    [self updateFrameLayout:news];
}

- (void) updateFrameLayout:(News *)news {
    
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.timeLabel.text = [NSString stringWithFormat: @"%@",timeAgo];
    }
    
    float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
    float yTitle = self.publisherImageView.frame.origin.y + self.publisherImageView.frame.size.height + constant.spacing;
    [self.titleLabel setFrame:CGRectMake(constant.margin, yTitle, constant.maxWidth, heightTitle)];
    float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
    float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
    if (heightDescription > heightDescMax){
        heightDescription = heightDescMax;
    }
    
    float yDesc = yTitle + heightTitle + constant.spacing;
    [self.descriptionLabel setFrame:CGRectMake(constant.margin, yDesc, constant.maxWidth, heightDescription)];
    float yThumbnail = yDesc + heightDescription + constant.spacing;
    [self.thumbnailImageView setFrame:CGRectMake(constant.margin, yThumbnail, constant.maxWidth, 190)];
    
    NSString *totalCmt = [NSString stringWithFormat:@"%@ bình luận",news.totalComments];
    float widthCmtLb = [formatString widthForString: totalCmt font: [constant fontNormal:14.0f]];
    
    float yTotalCmt = yThumbnail + 190 + constant.spacing;
    float xTotalCmt = constant.screenWidth - widthCmtLb - constant.margin;
    [self.totalCmtLabel setFrame: CGRectMake(xTotalCmt, yTotalCmt, constant.maxWidth, 18)];
    
}

@end
