//
//  OrangeBaseNetWorking.h
//  AFNetWorking网络请求
//
//  Created by Orange on 16/1/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

/**get，post，put，delete请求返回的请求数据*/
typedef void (^orangeBackDataBlock)(NSDictionary *dic);
/**网络状态*/
typedef void (^orangeNetDetection)(NSString *str);
/**下载任务时使用的枚举*/
typedef NS_ENUM(NSUInteger, OrangeDownTask) {
    OrangeNetWorkTask,//下载网络任务
    OrangeLocalTask//下载本地任务
};

@interface OrangeBaseNetWorking : NSObject

/**参数说明:（GET请求）url网络路径，dataBlock回传数据*/
+ (void)orangeGetRequestWithUrl:(NSString *)url
                    successData:(orangeBackDataBlock)dataBlock;
/**参数说明:（POST请求）url网络路径，dataBlock回传数据*/
+ (void)orangePostRequestWithUrl:(NSString *)url
                    successData:(orangeBackDataBlock)dataBlock;
/**参数说明:（PUT请求）url网络路径，dataBlock回传数据*/
+ (void)orangePutRequestWithUrl:(NSString *)url
                    successData:(orangeBackDataBlock)dataBlock;
/**参数说明:（Delete请求）url网络路径，dataBlock回传数据*/
+ (void)orangeDeleteRequestWithUrl:(NSString *)url
                    successData:(orangeBackDataBlock)dataBlock;

/**取消网络请求*/
+ (void)cancelNetWorkRequest;
/**检测当前的网络状态*/
+ (void)orangeNetWorkDetection:(orangeNetDetection)str;
/**使用AF进行下载fileName：下载到本地路径，urlString要获取data网络路径*/
+ (void)orangeDownloadWithFileName:(NSString *)fileName
                     withURLString:(NSString *)urlString
                      withTaskType:(OrangeDownTask)taskType;

@end








