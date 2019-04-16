//
//  DataSource.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject
- (void) fetchNewsData:(void(^)(NSMutableArray *arrayNews, NSError *error)) completion;
- (void) fetchNewsDetail:(void(^)(News *news, NSError *error)) completion;
- (void) fetchRelatedNews: (void(^)(NSMutableArray *arrayNews, NSError *error)) completion;
@end

NS_ASSUME_NONNULL_END
