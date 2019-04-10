//
//  TableMultiImageCell.m
//  DemoBM
//
//  Created by CPU11738 on 4/10/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "TableMultiImageCell.h"
#import "News.h"
#import "Image.h"


@implementation TableMultiImageCell
@synthesize titleLabel = _titleLabel;
@synthesize imageView1 = _imageView1;
@synthesize imageView2 = _imageView2;
@synthesize imageView3 = _imageView3;
@synthesize sourceLabel = _sourceLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        CGFloat widthScreen  = [UIScreen mainScreen].bounds.size.width;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, widthScreen - 30, 45)];
        self.titleLabel.numberOfLines = 3;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        
        [self addSubview: self.titleLabel];

        float spacing = 10;
        float margin = 15;
        float widthItem = (widthScreen / 3 ) - margin ;
        float y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
        self.imageView1 = [[UIImageView alloc] init];
        [self.imageView1 setFrame: CGRectMake(15, y, widthItem, 75)];
        [self.imageView1 setImage: [UIImage imageNamed: @"grayBackground.jpg"]];
        self.imageView1.layer.cornerRadius = 5.0;
        self.imageView1.clipsToBounds = true;
        self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.imageView1];

        self.imageView2 = [[UIImageView alloc] init];
        [self.imageView2 setFrame: CGRectMake(self.imageView1.frame.origin.x + widthItem + spacing, y, widthItem, 75)];
        [self.imageView2 setImage: [UIImage imageNamed: @"grayBackground.jpg"]];
        self.imageView2.layer.cornerRadius = 5.0;
        self.imageView2.clipsToBounds = true;
        self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.imageView2];

        self.imageView3 = [[UIImageView alloc] init];
        [self.imageView3 setFrame: CGRectMake(self.imageView2.frame.origin.x + widthItem + spacing, y, widthItem, 75)];
        [self.imageView3 setImage: [UIImage imageNamed: @"grayBackground.jpg"]];
        self.imageView3.layer.cornerRadius = 5.0;
        self.imageView3.clipsToBounds = true;
        self.imageView3.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: self.imageView3];
        
        self.sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, y + 75, widthScreen - 30, 25)];
        self.sourceLabel.numberOfLines = 0;
        self.sourceLabel.textColor = [UIColor lightGrayColor];
        self.sourceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
        
        [self addSubview: self.sourceLabel];

    }
    return self;
}

- (void)fillData:(News *) news {
    self.titleLabel.text = news.title;
    self.sourceLabel.text = news.publisher;
    NSUInteger count = 0;


    for (Image *img in news.images) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: img.url]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (count) {
                    case 0:
                        self.imageView1.image = [UIImage imageWithData: data];
                        break;
                    case 1:
                        self.imageView2.image = [UIImage imageWithData: data];
                        break;
                    default:
                        self.imageView3.image = [UIImage imageWithData: data];
                        break;
                }
            });
        });
        count++;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
