//
//  HotNewsCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "HotNewsCell.h"


@implementation HotNewsCell

float margin = 15;
float spacing = 10;

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;

        self.maxWidth = widthScreen - margin*2;
        self.thumbnailImageView = [[UIImageView alloc] initWithFrame: CGRectMake(margin, margin, self.maxWidth, 190)];
        self.thumbnailImageView.image = [UIImage imageNamed: @"thumbnail.png"];
        self.thumbnailImageView.layer.cornerRadius = 5.0;
        self.thumbnailImageView.clipsToBounds = true;
        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.thumbnailImageView];
        
        float yTitle = margin + self.thumbnailImageView.frame.size.height + spacing;
        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(margin, yTitle, self.maxWidth, 60)];
        self.titleLabel.numberOfLines = 3;
        self.titleLabel.textColor = [UIColor blackColor];
        
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        [self addSubview: self.titleLabel];
        
        float yDescription = yTitle + self.titleLabel.frame.size.height;
        self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(margin, yDescription, self.maxWidth, 45)];
        self.descriptionLabel.numberOfLines = 3;
        self.descriptionLabel.textColor = [UIColor grayColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self addSubview: self.descriptionLabel];

        float ySourceLabel = yDescription + self.descriptionLabel.frame.size.height;
        self.sourceLabel = [[UILabel alloc] initWithFrame: CGRectMake(margin, ySourceLabel, self.maxWidth, 25)];
        self.sourceLabel.numberOfLines = 1;
        self.sourceLabel.textColor = [UIColor lightGrayColor];
        self.sourceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        [self addSubview: self.sourceLabel];
        self.heightCell = ySourceLabel + self.sourceLabel.frame.size.height;

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
    float heightTitle = [self heightForString:news.title font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f] maxWidth: self.maxWidth];
    
    [self.titleLabel setFrame: CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.maxWidth, heightTitle)];
    
    float heightDescription = [self heightForString:news.desc font:[UIFont fontWithName:@"HelveticaNeue" size:14.0f] maxWidth: self.maxWidth];
    
    float yDescription = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + spacing;

    [self.descriptionLabel setFrame: CGRectMake(self.descriptionLabel.frame.origin.x
                                                , yDescription, self.maxWidth, heightDescription)];
    float heightSource = [self heightForString: @"100 binh luan" font:[UIFont fontWithName:@"HelveticaNeue" size:14.0f] maxWidth: self.maxWidth];
    float ySourceLabel = yDescription + self.descriptionLabel.frame.size.height + spacing;
    [self.sourceLabel setFrame:CGRectMake(self.sourceLabel.frame.origin.x, ySourceLabel, self.maxWidth, heightSource)];
    self.heightCell = 190 + heightTitle + heightDescription + 30;

    [self.delegate dataFillSuccess: self.indexPath];

    NSLog(@"%f",self.heightCell);
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
