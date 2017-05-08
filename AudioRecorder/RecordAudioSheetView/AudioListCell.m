//
//  AudioListCell.m
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "AudioListCell.h"

#define AUDIO_PATH        [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio", NSHomeDirectory()]
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "amr_wav_converter.h"


#define PATH_OF_FILE      [AUDIO_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"audio.text"]]

//#define AUDIO_DELETED_PATH [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio/deleted", NSHomeDirectory()]

#define AUDIO_FOBIDDENDELETED_USER_PATH [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio/forbidden/", NSHomeDirectory()]

//static  double       const  kMediaPlayX = 18.0f;
//static  double       const  kMediaPlayY = 15.0f;

@implementation AudioListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setValueWithfileInfo:(AudioFileInfoModel *)fileInfo{
    
    self.nameLab.text = fileInfo.name;
    self.sizeLab.text = fileInfo.duration;
    self.durationLab.text = fileInfo.fileSize;
    self.timeLab.text = fileInfo.time;
    
    NSString *fileAbsolutePath = [AUDIO_FOBIDDENDELETED_USER_PATH stringByAppendingPathComponent:fileInfo.path];
        
    NSFileManager* manager = [NSFileManager defaultManager];
    RecordView *recordPlayView ;
    
    if (![manager fileExistsAtPath:fileAbsolutePath]){
    
        recordPlayView =[RecordView initWithUrl:fileInfo.url];
        
    }else{
        
        recordPlayView =[RecordView initWithUrl:fileAbsolutePath];
    }
    CGRect frame= recordPlayView.frame;
    frame.size.width  =  self.bgView.bounds.size.width;
    recordPlayView.frame = frame;
    [self.bgView addSubview:recordPlayView];
    

}

@end
