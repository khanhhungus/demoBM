//
//  NewsDetailCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/11/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "NewsDetailCell.h"

@implementation NewsDetailCell
//@synthesize margin = _margin;

static NSString *content = @"Lê Dương Bảo Lâm được biết đến là diễn viên hài có tiếng tại khu vực phía Nam, nổi lên từ danh hiệu quán quân Cười xuyên Việt. Tuy nhiên, thời gian gần đây anh liên tục vướng phải ồn ào không hay, nổi bật là phát ngôn muốn mang trẻ cơ nhỡ về.Đặc biệt, đoạn clip ghi lại cảnh Bảo Lâm dùng tiếng Việt để miệt thị màu da một nhân viên bán hàng người nước ngoài khiến nhiều người bất bình. Nam diễn viên gọi người bán hàng là con quỷ. Những anti-fan chửi bới nặng lời, cho rằng tôi miệt thì người da màu thì có giải thích đến mấy họ cũng chẳng buồn hiểu. Vậy nên kệ đi. Tôi chỉ nói một lần duy nhất, tôi và những người bạn đến Ấn Độ hành hương, trao quà từ thiện. Những câu nói vui vẻ cũng giống như cách tôi trò chuyện khi livestream. Tất cả là giao tiếp giữa con người với con người.";


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
//    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
//        margin = 15;
//        maxWidth = widthScreen - margin*2;
//
//        float yTitle = self.margin + spacing;
//        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.margin, yTitle, self.maxWidth, 100)];
//        self.titleLabel.numberOfLines = 3;
//        self.titleLabel.textColor = [UIColor blackColor];
//        self.titleLabel.text = @"Lộ đường dây tổ chức mang thai hộ xuyên quốc gia lớn chưa từng có";
//        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0f];
//        [self addSubview: self.titleLabel];
//
//        self.iconPublisherImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.margin, yTitle, 20, 20)];
//        self.iconPublisherImageView.image = [UIImage imageNamed: @"thumbnail.png"];
//        [self addSubview: self.iconPublisherImageView];
//
//        float xPublisherLabel = self.margin + 20 + self.margin;
//        self.sourceLabel = [[UILabel alloc] initWithFrame: CGRectMake(xPublisherLabel, yTitle, self.maxWidth - xPublisherLabel, 25)];
//        self.sourceLabel.numberOfLines = 1;
//        self.sourceLabel.textColor = [UIColor lightGrayColor];
//        self.sourceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
//        [self addSubview: self.sourceLabel];
//
//        float yDescription = yTitle + 20 + self.margin;
//        self.descriptionLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.margin, yDescription, self.maxWidth, 45)];
//        self.descriptionLabel.numberOfLines = 0;
//        self.descriptionLabel.textColor = [UIColor blackColor];
//        self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
//        [self addSubview: self.descriptionLabel];
//
//
//        self.thumbnailImageView = [[UIImageView alloc] init];
//        self.thumbnailImageView.layer.cornerRadius = 5.0;
//        self.thumbnailImageView.clipsToBounds = true;
//        self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
//        [self addSubview: self.thumbnailImageView];
//
//        self.contentLabel = [[UILabel alloc] init];
//        self.contentLabel.numberOfLines = 0;
//        self.contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0f];
//        [self addSubview: self.contentLabel];
//        self.heightCell = 1000;
//
//    }
//    return self;
//}

- (void) fillData: (News *)news {
    self.titleLabel.text = news.title;
    self.contentLabel.text = content;
    FormatTime *formatTime = [[FormatTime alloc] init];
    double date = [news.date doubleValue];
    if (news.date != nil) {
        NSDate *timeStamp = [NSDate dateWithTimeIntervalSince1970: (NSTimeInterval) date];
        NSString *timeAgo = [formatTime agoStringFromTime: timeStamp];
        self.sourceLabel.text = [NSString stringWithFormat: @"%@ • %@ • %@ bình luận",news.publisher,timeAgo,news.totalComments];
        
    } else {
        self.sourceLabel.text = [NSString stringWithFormat: @"%@ • %@ bình luận",news.publisher,news.totalComments];
    }
    
    self.descriptionLabel.text = news.desc;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSData * iconData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.publisherIcon]];
        NSData * thumbnailData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: news.avatarURL]];
        if ( iconData == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconPublisherImageView.image = [UIImage imageWithData: iconData];
            self.thumbnailImageView.image = [UIImage imageWithData: thumbnailData];
        });
    });
    
//    [self updateFrame:news];
}
//- (void) updateFrame:(News *)news {
//    float heightTitle = [self heightForString:news.title font:[UIFont fontWithName:@"HelveticaNeue-Medium" size: 24.0f] maxWidth: self.maxWidth];
//    [self.titleLabel setFrame: CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.maxWidth, heightTitle)];
//
//    float yIcon = self.margin +  self.titleLabel.frame.origin.y + heightTitle;
//
//    [self.iconPublisherImageView setFrame: CGRectMake(self.margin, yIcon, 20, 20)];
//    [self.sourceLabel setFrame: CGRectMake(self.sourceLabel.frame.origin.x, yIcon, self.sourceLabel.frame.size.width, 25)];
//
//    float heightDescription = [self heightForString:news.desc font:[UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f] maxWidth: self.maxWidth];
//    float yDescription = yIcon + 20 + self.margin;
//    [self.descriptionLabel setFrame: CGRectMake(self.margin, yDescription, self.maxWidth, heightDescription)];
//
//    float yThumbnail = yDescription + self.margin + self.descriptionLabel.frame.size.height;
//    [self.thumbnailImageView setFrame:CGRectMake(self.margin, yThumbnail, self.maxWidth, 190.0)];
//    float heightContent = [self heightForString:content font:[UIFont fontWithName:@"HelveticaNeue" size:20.0f] maxWidth:self.maxWidth];
//
//    float yContent = yThumbnail + 190 + self.margin;
//    [self.contentLabel setFrame: CGRectMake(self.margin, yContent, self.maxWidth, heightContent)];
//
//    self.heightCell = self.margin*5 + yContent + heightContent;
//    [self.delegate dataFillSuccess:self.indexPath];
//}


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

@end
