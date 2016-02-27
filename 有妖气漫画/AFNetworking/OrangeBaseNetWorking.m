//
//  OrangeBaseNetWorking.m
//  AFNetWorking网络请求
//
//  Created by Orange on 16/1/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "OrangeBaseNetWorking.h"

/**
 *1、所有网络请求，都是由manager构建的
 *2、默认提交请求的数据是二进制的，返回格式是JSON
 *   如果提交数据是JSON，需要讲请求格式设置为AFJSONRequestSerializer
 *3、请求格式
 *   AFHTTPRequestSerializer 二进制格式
 *   AFJSONRequestSerializer JSON格式
 *   AFPropertyListRequestSerializer PList格式（一种特殊的XML）
 *4、返回格式
 *   AFHTTPResponseSerializer 二进制格式
 *   AFJSonReponseSerializer Json格式
 *   AFXMLParserResponseSerializer XML，只能返回XMLParser，需要自己通过代理方法解析
 *   AFXMLDocumentResponseSerializer （用于Mac OS X）
 *   AFPropertyListResponseSerializer PList格式
 *   AFImageResponseSerializer Image格式
 */

@implementation OrangeBaseNetWorking

//GET请求
+ (void)orangeGetRequestWithUrl:(NSString *)url successData:(orangeBackDataBlock)dataBlock
{
    AFHTTPSessionManager *afhttp = [AFHTTPSessionManager manager];
    [afhttp GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            dataBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误内容%@",task);
    }];
}

//POST请求
+ (void)orangePostRequestWithUrl:(NSString *)url
                     successData:(orangeBackDataBlock)dataBlock
{
    AFHTTPSessionManager *afhttp = [AFHTTPSessionManager manager];
    [afhttp POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            dataBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误内容%@",task);
    }];
}

//PUT请求
+ (void)orangePutRequestWithUrl:(NSString *)url
                    successData:(orangeBackDataBlock)dataBlock
{
    AFHTTPSessionManager *afhttp = [AFHTTPSessionManager manager];
    [afhttp PUT:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            dataBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误内容%@",task);
    }];
}

//DELETE请求
+ (void)orangeDeleteRequestWithUrl:(NSString *)url
                       successData:(orangeBackDataBlock)dataBlock
{
    AFHTTPSessionManager *afhttp = [AFHTTPSessionManager manager];
    [afhttp DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            dataBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误内容%@",task);
    }];
}

//取消网络
+ (void)cancelNetWorkRequest
{

}

//检测网络环境
+ (void)orangeNetWorkDetection:(orangeNetDetection)str
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == -1) {
            str(@"网络情况未知");
        }else if (status == 0){
            str(@"无网络");
        }else if (status == 1){
            str(@"3G网络");
        }else if (status == 2){
            str(@"wifi网络");
        }
    }];
}

//指定路径下载文件
+ (void)orangeDownloadWithFileName:(NSString *)fileName
                     withURLString:(NSString *)urlString
                      withTaskType:(OrangeDownTask)taskType
{
    //NSURLSessionConfiguration用于完成下载任务（可以断点续传，后台下载）
    NSURLSessionConfiguration *sesConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //AF对NSURLSessionDownload的二次封装
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:sesConfiguration];
    //URL指针
    NSURL *url;
    if (taskType == OrangeNetWorkTask) {
        //下载网络数据操作（如果是网络路径需要转码一次）
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //构建网络URL
        url = [NSURL URLWithString:urlString];
    }else if (taskType == OrangeLocalTask){
        //下载本地数据操作
        url = [NSURL fileURLWithPath:urlString];
    }
    //进行Request请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //开始下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //（1）指定下载文件保存的路径
        NSString *downfileName = [fileName stringByAppendingPathComponent:response.suggestedFilename];
        NSURL *fileUrl = [NSURL fileURLWithPath:downfileName];
        return fileUrl;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@-----------%@",filePath,error);
    }];
    //开始任务
    [task resume];
}



@end











