//
//  NilDataTip.m
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "NilDataTipView.h"

@implementation NilDataTipView
+ (instancetype)getInstance{
    
    NilDataTipView* instance;
    
    NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"NilDataTip" owner:self options:nil];
    instance = [nibs objectAtIndex:0];
    
    return instance;
}
@end
