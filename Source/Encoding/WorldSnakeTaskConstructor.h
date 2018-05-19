//
//  WorldSnakeTaskConstructor.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/15.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WSURLComponents;
@class WorldSnakeRequest;
@class WorldSnakeDataRequest;
@class WorldSnakeDownloadRequest;
@class WorldSnakeUploadRequest;
@class WorldSnakeStreamRequest;

@protocol WSEncodingURLRequestConvertible;

typedef NS_ENUM(NSInteger, XYWSSessionResponseDisposition) {
    XYWSSessionResponseCancel = 0,
    XYWSSessionResponseFinished,
    XYWSSessionResponseRetry,
};

@protocol WorldSnakeTaskConvertible <NSObject>

@optional
- (NSURLSessionDataTask * _Nullable)dataTaskWithSession:(NSURLSession *)session request:(WorldSnakeDataRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;
- (NSURLSessionDownloadTask * _Nullable)downloadTaskWithSession:(NSURLSession *)session request:(WorldSnakeDownloadRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;
- (NSURLSessionUploadTask * _Nullable)uploadTaskWithSession:(NSURLSession *)session request:(WorldSnakeUploadRequest * _Nullable)request URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest;

- (XYWSSessionResponseDisposition)didFinishReceiveData:(NSData * _Nullable)data request:(WorldSnakeRequest *)request error:(NSError * _Nullable)error;

@end

@interface WorldSnakeTaskConstructor : NSObject <WorldSnakeTaskConvertible>

@end


NS_ASSUME_NONNULL_END
