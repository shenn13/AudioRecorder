//
//  RecordView.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@protocol finisedPlayDelegate<NSObject>
@optional
- (void)finishedPlay;
@end


//typedef void (^FinishedPlayStatusBlock) (NSString *status);

@interface RecordView : UIView<AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playStateImg;
@property (weak,nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIImageView *defaultPlayStateImg;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;

#pragma mark -- yyb--modify--

@property (nonatomic,weak) id<finisedPlayDelegate> delegate;
#pragma mark - actions

+(instancetype)initWithUrl:(NSString*)url;

+(instancetype)initWithStaticUrl:(NSString*)url;

+(void)stopAllPlay;

- (IBAction)playClick:(UIButton *)sender;

- (void)stopPlay;

@end
