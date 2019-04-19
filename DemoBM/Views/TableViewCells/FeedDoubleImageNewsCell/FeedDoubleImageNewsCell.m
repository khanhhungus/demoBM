//
//  FeedDoubleImageNewsCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/18/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "FeedDoubleImageNewsCell.h"

@implementation FeedDoubleImageNewsCell {
    HeaderPublisherView *headerView;
    TitleDescriptionView *titleView;
    FooterNewsView *footerView;
    Constant *constant;
    FormatString *formatString;
    PhotoDoubleView *photoDoubleView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        constant = [[Constant alloc] init];
        formatString = FormatString.new;
        headerView = [[NSBundle.mainBundle loadNibNamed:@"HeaderPublisherView" owner:self options:nil] objectAtIndex:0] ;
        [headerView setFrame:CGRectMake(constant.margin, 0, constant.maxWidth, 35)];
        [self addSubview: headerView];
        
        titleView = [[NSBundle.mainBundle loadNibNamed:@"TitleDescriptionView" owner:self options:nil] objectAtIndex:0] ;
        [titleView setFrame:CGRectMake(constant.margin, 40, constant.maxWidth, 50)];
        [self addSubview: titleView];
        
        footerView = [[NSBundle.mainBundle loadNibNamed:@"FooterNewsView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:footerView];
        
        photoDoubleView = [[NSBundle.mainBundle loadNibNamed:@"PhotoDoubleView" owner:self options:nil] objectAtIndex:0];
        [self addSubview: photoDoubleView];
    }
    return self;
}

-(void) fillData:(News *)news {
    [headerView setFrame:CGRectMake(constant.margin, 0, constant.maxWidth, 35)];

    float heightTitle = [formatString heightForString:news.title font: [constant fontMedium: 16.0f] maxWidth: constant.maxWidth];
    float heightDescMax = [constant heightForOneLine:[constant fontNormal: 14.0f]] * 3;
    float heightDescription = [formatString heightForString:news.desc font: [constant fontNormal: 14.0f] maxWidth: constant.maxWidth];
    if (heightDescription > heightDescMax){
        heightDescription = heightDescMax;
    }
    
    float heightForTitleDescView = heightTitle + heightDescription + constant.spacing;
    [titleView setFrame:CGRectMake(constant.margin, 45, constant.maxWidth, heightForTitleDescView)];
    
    float yPhotoView = heightForTitleDescView + 45 + constant.spacing;
    float yFooterView = yPhotoView + constant.spacing + photoDoubleView.heightView;
    
    [photoDoubleView setFrame:CGRectMake(constant.margin, yPhotoView,constant.maxWidth, photoDoubleView.heightView)];
    [photoDoubleView fillData:news];
    
    float heightOneLine = [constant heightForOneLine:[constant fontNormal:14]];
    [footerView setFrame:CGRectMake(constant.margin, yFooterView, constant.maxWidth, heightOneLine)];
    [headerView fillData:news];
    [titleView fillData:news];
    [footerView fillData:news];
}


@end
