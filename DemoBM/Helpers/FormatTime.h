//
//  FormatTime.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/9/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormatTime : NSObject
- (NSString*) agoStringFromTime: (NSDate*) dateTime;
@end

NS_ASSUME_NONNULL_END
