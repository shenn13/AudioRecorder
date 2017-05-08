//
//  AudioFileInfoModel.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UploadRecordState) {
    UploadRecordStateNotStart = 0,
    UploadRecordStateStart,
    UploadRecordStateEnd
};

@interface AudioFileInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString   *url;      //网络url
@property (strong, nonatomic) NSString *path; //本地路径
@property (strong, nonatomic) NSString *describe; //录音描述
@property (strong, nonatomic) NSString *time; //最后录音时间,yyyy-MM-dd HH:mm:ss

@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *fileTime;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *fileSize;


@property (nonatomic, assign) UploadRecordState state;


@end
