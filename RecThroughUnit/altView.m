//
//  altView.m
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/05/29.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import "altView.h"

@implementation altView

-(id) init {
    if (self = [super init]) {
        _subView = [[UIView alloc] init];
    }
    return self;
}
-(void) layoutSubviews {
    [super layoutSubviews];
    
    // レイアウト調整はここでやる
    //_subView.frame = CGRectMake(50,50,50,50);
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    BOOL isPad = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
    
    // iPadの場合は高さ300、iPhoneの場合は高さ100
    float hogeH = (isPad) ? 300 : 100;
    _subView.frame = CGRectMake(0, 0, hogeH, width);
    NSLog(@"thisIsLayoutSubViews");
}

@end
