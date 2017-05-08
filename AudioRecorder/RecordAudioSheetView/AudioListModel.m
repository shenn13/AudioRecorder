//
//  AuidoListModel.m
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "AudioListModel.h"
#import "AudioFileInfoModel.h"



@implementation AudioListModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    if (_dataArray.count >0) {
        
        [aCoder encodeObject:_dataArray forKey:@"dataArray"];
        
    }else{
        [aCoder encodeObject:@[] forKey:@"dataArray"];
    }
    [aCoder encodeObject:_endTime forKey:@"time"];
    
    [aCoder encodeBool:_isFinished forKey:@"finished"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.dataArray = [aDecoder decodeObjectForKey:@"dataArray"];

        self.endTime = [aDecoder decodeObjectForKey:@"time"];
        
        self.isFinished = [aDecoder decodeBoolForKey:@"finished"];
        
    }
    return self;
}

@end
