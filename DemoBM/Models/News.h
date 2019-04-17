//
//  News.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Body.h"
#import "Image.h"

NS_ASSUME_NONNULL_BEGIN

@interface News : NSObject

@property (strong, nonatomic) NSString *contentID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSString *publisherIcon;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) NSString *totalComments;
@property (strong, nonatomic) NSNumber *date;
@property (strong, nonatomic) NSMutableArray<Image *> *images;
@property (strong, nonatomic) NSMutableArray<Body *> *body;
@property (strong, nonatomic) NSDictionary *cellHeight;
@property (strong, nonatomic) NSString *content;
@end

NS_ASSUME_NONNULL_END
