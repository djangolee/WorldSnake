//
//  WorldSnakeTaskConstructor.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/15.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeTaskConstructor.h"

#import "WSURLComponents.h"
#import "WorldSnakeSession.h"
#import "WorldSnakeDataRequest.h"
#import "WorldSnakeDownloadRequest.h"
#import "WorldSnakeUploadRequest.h"

@implementation WorldSnakeTaskConstructor

- (NSURLSessionDataTask * _Nullable)dataTaskWithSession:(NSURLSession *)session request:(WorldSnakeDataRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [session dataTaskWithRequest:URLRequest.asURLRequest];
}

- (NSURLSessionDownloadTask * _Nullable)downloadTaskWithSession:(NSURLSession *)session request:(WorldSnakeDownloadRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [session downloadTaskWithRequest:URLRequest.asURLRequest];
}

- (NSURLSessionUploadTask * _Nullable)uploadTaskWithSession:(NSURLSession *)session request:(WorldSnakeUploadRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [session uploadTaskWithRequest:URLRequest.asURLRequest fromData:NSData.new];
}

- (XYWSSessionResponseDisposition)didFinishReceiveData:(NSData * _Nullable)data request:(WorldSnakeRequest *)request error:(NSError * _Nullable)error {
    return XYWSSessionResponseFinished;
}

@end
