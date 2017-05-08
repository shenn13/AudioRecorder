//
//  AudioFileInfoModel.m
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import "AudioFileInfoModel.h"
#import "NSString+Enhance.h"

@implementation AudioFileInfoModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.path forKey:@"path"];
    [encoder encodeObject:self.describe forKey:@"describe"];
    [encoder encodeObject:self.time forKey:@"time"];
    [encoder encodeObject:self.duration forKey:@"duration"];
    [encoder encodeObject:self.fileTime forKey:@"fileTime"];
    [encoder encodeObject:self.fileSize forKey:@"fileSize"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInteger:self.state forKey:@"state"];

}

- (id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.url = [decoder decodeObjectForKey:@"url"];
        self.path = [decoder decodeObjectForKey:@"path"];
        self.describe = [decoder decodeObjectForKey:@"describe"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.duration = [decoder decodeObjectForKey:@"duration"];
        self.fileTime = [decoder decodeObjectForKey:@"fileTime"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.state = [decoder decodeIntegerForKey:@"state"];
        self.fileSize = [decoder decodeObjectForKey:@"fileSize"];
    }
    return self;
}
@end
