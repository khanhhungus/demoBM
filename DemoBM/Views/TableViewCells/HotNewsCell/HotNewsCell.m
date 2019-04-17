//
//  HotNewsCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "HotNewsCell.h"


@implementation HotNewsCell {
    Constant *constant;
    FormatString *formatString;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        constant = Constant.new;
        formatString = FormatString.new;
        AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
        Theme *theme = appDelegate.currentTheme;
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame: CGRectMake(constant.margin, constant.margin, constant.maxWidth, 190)];
        self.thumbnailImageView.layer.cornerRadius = 5.0;
        self.thumbnailImageView.clipsToBounds = true;
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.thumbnailImageView];
        
        self.titleLabel = [[AppLabel alloc] init];
        self.titleLabel.numberOfLines = 3;
        self.titleLabel.textColor = theme.labelColor;
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        [self addSubview: self.titleLabel];
        
        self.descriptionLabel = [[AppLabel alloc] init];
        self.descriptionLabel.numberOfLines = 3;
        self.descriptionLabel.textColor = theme.labelColor;
        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self addSubview: self.descriptionLabel];

        self.sourceLabel = [[AppSubLabel alloc] init];
        self.sourceLabel.numberOfLines = 1;
        self.sourceLabel.textColor = theme.secondaryLabelColor;
        self.sourceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self addSubview: self.sourceLabel];

    }
    return self;
}

- (void)fillData: (News *)news {
    self.titleLabel.text = news.title;
    self.descriptionLabel.text = news.desc;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImageView.image = [UIImage imageWithData: data];
        });
    });
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.sourceLabel.text = [NSString stringWithFormat: @"%@ • %@ • %@ bình luận",news.publisher,timeAgo,news.totalComments];
    } else {
        self.sourceLabel.text = [NSString stringWithFormat: @"%@ • %@ bình luận",news.publisher,news.totalComments];
    }
    [self updateFrame:news];
}

- (void) updateFrame:(News *)news {
    float heightTitle = [self heightForString:news.title font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f] maxWidth: constant.maxWidth];
    float yTitle = self.thumbnailImageView.frame.size.height + constant.spacing + constant.margin;
    [self.titleLabel setFrame: CGRectMake(constant.margin, yTitle, constant.maxWidth, heightTitle)];
    float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
    float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
    if (heightDescription > heightDescMax){
        heightDescription = heightDescMax;
    }
    
    float yDescription = yTitle + heightTitle + constant.spacing;

    [self.descriptionLabel setFrame: CGRectMake(constant.margin, yDescription, constant.maxWidth, heightDescription)];
    float heightSource = [constant heightForOneLine:[constant fontNormal: 14.0f]];
    float ySourceLabel = yDescription + heightDescription + constant.spacing;
    [self.sourceLabel setFrame:CGRectMake(constant.margin, ySourceLabel, constant.maxWidth, heightSource)];
}

- (CGFloat)heightForString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        // no text means no height
        return 0;
    }
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height) + 1; // add 1 point as padding
    
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
