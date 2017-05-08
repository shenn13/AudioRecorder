//
//  AudioListCell.h
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordView.h"
#import "AudioFileInfoModel.h"

@protocol AudioListCellDelegate<NSObject>
@optional
- (void)cleanTheMediaPlayViewWithRecord:(UIButton *)sender;

@end

@interface AudioListCell : UITableViewCell<finisedPlayDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sizeLab;
@property (weak, nonatomic) IBOutlet UILabel *durationLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UIView *bgView;

- (void)setValueWithfileInfo:(AudioFileInfoModel *)fileInfo;
/**
 * 是否重新上传
 */


@property (nonatomic,weak) id<AudioListCellDelegate> delegate;


@end
