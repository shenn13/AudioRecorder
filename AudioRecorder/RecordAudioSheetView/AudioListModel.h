//
//  AuidoListModel.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^AudioListComplete)(NSError*);

@interface AudioListModel : NSObject<NSCoding>

@property (nonatomic,strong) NSArray *dataArray;//audioFileInfoModel


@property (nonatomic,strong) NSString *endTime;  //记录最后操作的时间

@property (nonatomic,assign) BOOL isFinished;    //任务结束标记



@end
