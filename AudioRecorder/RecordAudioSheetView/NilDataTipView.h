//
//  NilDataTip.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NilDataTipView : UIView
@property (strong, nonatomic) IBOutlet UILabel *tipTextLabel;
+ (instancetype)getInstance;
@end
