//
//  Constant.h
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/15/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FormatString.h"

NS_ASSUME_NONNULL_BEGIN

@interface Constant : NSObject

@property (readonly, nonatomic) float screenWidth;
@property (readonly, nonatomic) float maxWidth;
@property (readonly, nonatomic) float margin;
@property (readonly, nonatomic) float spacing;

-(UIFont *)fontMedium:(CGFloat)size;
-(UIFont *)fontNormal:(CGFloat)size;
-(float) heightForOneLine: (UIFont *) font;

@end

NS_ASSUME_NONNULL_END
