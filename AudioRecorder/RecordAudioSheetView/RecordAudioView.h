//
//  RecordAudioView.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  AMR 文件信息
 */
@interface AudioFileInfo  : NSObject

/**
 *  文件路径
 */
@property (nonatomic, copy) NSString *audioUrl;

/**
 *  文件时间
 */
@property (nonatomic, copy) NSString *audioduration;

/**
 *  文件大小
 */
@property (nonatomic, copy) NSString *audiofileSize;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *audioName;

/**
 *  结束时间
 */
@property (nonatomic, copy) NSString *time;




@end

@protocol RecordAudioDelegate <NSObject>

@optional

- (void)recorderdidRecordWithFile:(AudioFileInfo *)fileInfo;

- (void)recordHidecomplete:(BOOL)success;



@end

@interface RecordAudioView : UIView

+(instancetype)initWithDelegate:(id)delegate;

-(void)show;

-(void)hide;

/**
 *  第几个录音文件
 */
@property (weak,nonatomic) id<RecordAudioDelegate> delegate;

@end
