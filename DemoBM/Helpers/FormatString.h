//
//  NSSTring+.h
//  DemoBM
//
//  Created by CPU11738 on 4/12/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormatString : NSObject
- (CGFloat)heightForString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (NSString *)convertHTML:(NSString *)html;
- (CGFloat)widthForString:(NSString *)text font:(UIFont *)font;
@end

NS_ASSUME_NONNULL_END
