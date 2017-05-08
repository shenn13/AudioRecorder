//
//  WaterDropAudioViewController.m
//  AudioRecorder
//
//  Created by shen on 2017/5/6.
//  Copyright © 2017年 shen. All rights reserved.
//
#import "PCHHeader.h"

#import "WaterDropAudioViewController.h"

#import "RecordAudioView.h"

#import "AudioListCell.h"

#import "AudioFileInfoModel.h"

#import "NilDataTipView.h"

#import "AudioListModel.h"

#import "NSDate+Ldate.h"

#import "MBProgressHUD.h"

#import "PRNAmrRecorder.h"

#define RECVICE_KEY @"recvice_key_V1B2"

@interface WaterDropAudioViewController () <RecordAudioDelegate,UITableViewDataSource,UITableViewDelegate,AudioListCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NilDataTipView *nilView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) RecordAudioView *audioView;

@end

#define AUDIO_PATH        [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio", NSHomeDirectory()]

#define PATH_OF_FILE      [AUDIO_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"audio.text"]]
//
//#define AUDIO_DELETED_PATH [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio/deleted", NSHomeDirectory()]

#define AUDIO_FOBIDDENDELETED_USER_PATH [NSString stringWithFormat:@"%@/Library/Caches/ghost/audio/forbidden/", NSHomeDirectory()]

static  NSString    *const  kfileName   = @"newRecord";
static  double       const  kcellheight = 75.0;

@implementation WaterDropAudioViewController



-(void)setNavigationBar{
    
    self.title = @"录音记录";
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_add_nor"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:250.0/255 green:70.0/255 blue:70.0/255 alpha:1]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}


#pragma mark --- lifetime of VC
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setNavigationBar];
    self.dataArray = [NSMutableArray array];

    [self filePathNeedCreate];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:@"reloadTableView" object:nil];
}


-(void)rightButtonClicked{
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    HUD.mode = MBProgressHUDModeText;
    HUD.margin = 10.f;
    HUD.yOffset = 15.f;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.detailsLabelText = @"请不要在未完成时中断录音";
    HUD.labelFont = [UIFont systemFontOfSize:13];
    [HUD hide:YES afterDelay:1.5];
    
    [RecordView stopAllPlay];
    
    [self showRecordView];
}


- (void)selfCheckRecordingStatus{
    
    BOOL bRecord = [PRNAmrRecorder manager].isRecording;
    
    if (bRecord) {
        
        [self showRecordView];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showOrhideView];
    [self selfCheckRecordingStatus];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self removeRecordView];
    [RecordView stopAllPlay];
}

- (void)showOrhideView{
    
    NSArray *array= [self readFromFile];
    
    if (array.count>0 ) {
        
        NSData *audioModelReadData = [[NSUserDefaults standardUserDefaults] objectForKey:RECVICE_KEY];
        
        AudioListModel *audioModel =  [NSKeyedUnarchiver unarchiveObjectWithData:audioModelReadData];
        
        if (!audioModel) {
            
            audioModel = [[AudioListModel alloc] init];
        }
        
        [self hideNoRecord];
        
        self.dataArray = [array mutableCopy];
        
        [self.tableView reloadData];
        
    }else{
        
        [self showNoRecord];
        
        if (![PRNAmrRecorder manager].isRecording) {
            
            [self showRecordView];
        }
    }
    
}
- (void)showNoRecord{
    self.nilView = [NilDataTipView getInstance];
    _nilView.frame =CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.nilView];
    
}
- (void)hideNoRecord{
    
    if (self.nilView) {
        
        [self.nilView removeFromSuperview];
    }
    
}
- (void)showRecordView{
    
    self.audioView = [RecordAudioView initWithDelegate:self];
    
    self.audioView.delegate = self;
    
    [self.audioView show];
    
    
}
- (void)removeRecordView{
    
    if (self.audioView) {
        
        [self.audioView removeFromSuperview];
        
        self.audioView = nil;
        
    }
}

#pragma mark --- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kcellheight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdetify = @"AudioListCell";
    
    AudioListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify forIndexPath:indexPath];
    
    AudioFileInfoModel *fileInfo = self.dataArray[self.dataArray.count-indexPath.row-1];
    
    [cell setValueWithfileInfo:fileInfo];
    
    __weak __typeof(&*self)weakSelf = self;
    
    cell.delegate = weakSelf;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//删除数据源
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AudioFileInfoModel *model = self.dataArray[self.dataArray.count-indexPath.row-1];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList =[fileManager contentsOfDirectoryAtPath:AUDIO_FOBIDDENDELETED_USER_PATH error:NULL];
    for (NSString *file in fileList){
        
        if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@%@",AUDIO_FOBIDDENDELETED_USER_PATH,model.path]]){
            [fileManager removeItemAtPath:
             [NSString stringWithFormat:@"%@%@",AUDIO_FOBIDDENDELETED_USER_PATH,model.path] error:nil];
            NSLog(@"视频删除成功%@",file);
        }
    }
    
    
    [self.dataArray removeObjectAtIndex:self.dataArray.count - indexPath.row - 1];
    
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    

    NSData *audioModelReadData = [[NSUserDefaults standardUserDefaults] objectForKey:RECVICE_KEY];
    AudioListModel *audioModel =  [NSKeyedUnarchiver unarchiveObjectWithData:audioModelReadData];
    
    if (!audioModel) {
        
        audioModel = [[AudioListModel alloc] init];
    }
    NSMutableArray *array = [NSMutableArray arrayWithArray:audioModel.dataArray];
    [array removeObjectAtIndex:array.count - indexPath.row - 1];
    audioModel.dataArray = [array copy];
    NSString *endtime =  [NSDate currentDate];
    audioModel.endTime = endtime;
    NSData *audioWriteModelData = [NSKeyedArchiver archivedDataWithRootObject:audioModel];
    
    [[NSUserDefaults standardUserDefaults] setObject:audioWriteModelData forKey:RECVICE_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


#pragma mark --- RecordAudioDelegate
- (void)recorderdidRecordWithFile:(AudioFileInfo *)fileInfo{
    
    [self.audioView hide];
    
    [self hideNoRecord];
    
    AudioFileInfoModel *model=  [self setAudioFileInfoModel:fileInfo];
    
    [self insertTableViewCell:model];
    
    
    NSData *audioModelReadData = [[NSUserDefaults standardUserDefaults] objectForKey:RECVICE_KEY];
    AudioListModel *audioModel =  [NSKeyedUnarchiver unarchiveObjectWithData:audioModelReadData];
    
    if (!audioModel) {
        
        audioModel = [[AudioListModel alloc] init];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:audioModel.dataArray];
    
    [array addObject:model];
    
    audioModel.dataArray = [array copy];
    
    NSString *endtime =  [NSDate currentDate];
    audioModel.endTime = endtime;
    
    NSData *audioWriteModelData = [NSKeyedArchiver archivedDataWithRootObject:audioModel];
    
    [[NSUserDefaults standardUserDefaults] setObject:audioWriteModelData forKey:RECVICE_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}
- (AudioFileInfoModel *)setAudioFileInfoModel:(AudioFileInfo *)fileInfo{
    
    AudioFileInfoModel *model = [[AudioFileInfoModel alloc] init];
    
    model.path      = fileInfo.audioUrl;
    model.duration = fileInfo.audioduration;
    model.fileTime = fileInfo.time;
    model.fileSize = fileInfo.audiofileSize;
    NSString *name      = fileInfo.audioName;
    
    
    if ([name hasPrefix:kfileName]) {
        
        name = [@"新录音 " stringByAppendingString:[NSString stringWithFormat:@"%lu",self.dataArray.count + 1]];
    }
    model.name       = name;
    model.describe   = name;
    model.time       = fileInfo.time;
    model.url          = @"";
    
    return model;
}


- (void)insertTableViewCell:(AudioFileInfoModel *)fileInfo{
    
    [self.dataArray insertObject:fileInfo atIndex:self.dataArray.count];
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
}



- (void)recordingPopToViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadTableView:(NSNotification *)no{
    
    
    NSData *audioModelReadData = [[NSUserDefaults standardUserDefaults] objectForKey:RECVICE_KEY];
    
    AudioListModel *audioModel =  [NSKeyedUnarchiver unarchiveObjectWithData:audioModelReadData];
    
    if (audioModel) {
        
        self.dataArray = [NSMutableArray arrayWithArray:audioModel.dataArray];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
        
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    
}

#pragma mark --- createFile
- (void)filePathNeedCreate{
    [self createDir:AUDIO_FOBIDDENDELETED_USER_PATH];
    
}
- (void)createDir:(NSString *)filePath{
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) )
    {
        BOOL success=  [fileManager
                        createDirectoryAtPath:filePath
                        withIntermediateDirectories:YES
                        attributes:nil error:nil];
        if (success) {
            
            NSLog(@"create the file path success%@",filePath);
        }
    }
}

- (NSArray *)readFromFile{
    
    NSMutableArray *readArray = [NSMutableArray array];
    
    NSData *audioModelReadData = [[NSUserDefaults standardUserDefaults] objectForKey:RECVICE_KEY];
    
    AudioListModel *audioModel =  [NSKeyedUnarchiver unarchiveObjectWithData:audioModelReadData];
    
    if (audioModel) {
        
        readArray  =[audioModel.dataArray mutableCopy];
        
        if (readArray.count>0) {
            
            NSLog(@"read from file success");
        }
        
    }
    return readArray;
    
}
- (void)dealloc{
    
    NSLog(@"dealloc and remove the notification");
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"reloadTableView"];
    
}

@end
