//
//  PCHHeader.h
//  GhostTask
//
//  Created by 讨厌西红柿 on 15/12/31.
//  Copyright © 2015年 美赛达. All rights reserved.
//

#ifndef GhostTask_PCHHeader_h
#define GhostTask_PCHHeader_h

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


#define POSTURL @"ghostApi/route/commonPost"
#define HttpNetworkTimeout		20.0

#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define SCREENWIDTH  [[UIScreen mainScreen] bounds].size.width  //屏幕宽度

#define IOSVersion  [[[UIDevice currentDevice] systemVersion] floatValue]
#define NS_NOTIFICAITON_FINISHED_REFLUSHDATA @""  //完成任务刷新任务列表
#define NS_NOTIFICATION_START_REFLUSHDATA @"" //启动任务刷新数据

#endif /* PCHHeader_h */
