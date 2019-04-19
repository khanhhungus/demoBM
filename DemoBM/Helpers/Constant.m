//
//  Constant.m
//  DemoBM
//
//  Created by Khanh Hung Nguyen on 4/15/19.
//  Copyright © 2019 Khanh Hung Nguyen. All rights reserved.
//

#import "Constant.h"

@implementation Constant {
    FormatString *formatString;
}
#define UIColorFromRGB(rgbHex) [UIColor colorWithRed:((float)((rgbHex & 0xFF0000) >> 16))/255.0 green:((float)((rgbHex & 0xFF00) >> 8))/255.0 blue:((float)(rgbHex & 0xFF))/255.0 alpha:1.0]

- (instancetype)init
{
    self = [super init];
    if (self) {
        _screenWidth  = [UIScreen mainScreen].bounds.size.width;
        _margin = 15;
        _spacing = 10;
        _maxWidth = _screenWidth - _margin*2;
        formatString = FormatString.new;
    }
    return self;
}

- (UIFont *)fontMedium:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:size];
}

- (UIFont *)fontNormal:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

-(float) heightForOneLine: (UIFont *) font {
    return [formatString heightForString:@"1 dong " font:font maxWidth:self.maxWidth];
}

+(int)getConstant {
    return 100;
}
@end
