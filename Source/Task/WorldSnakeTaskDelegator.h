//
//  WorldSnakeTaskDelegator.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WorldSnakeTaskConstructor.h"

NS_ASSUME_NONNULL_BEGIN

@class WorldSnakeRequest;

@protocol WorldSnakeTaskDelegate <NSObject>

- (void)task:(NSURLSessionTask *)task didReceiveProgress:(NSProgress *)progress;
- (void)task:(NSURLSessionTask *)task didFinishReceiveData:(NSData *)data;
- (void)task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error disposition:(XYWSSessionResponseDisposition)disposition;

@end

@interface WorldSnakeTaskDelegator : NSObject

@property (nonatomic, weak, nullable, readonly) WorldSnakeRequest <WorldSnakeTaskDelegate> *request;

@property (nonatomic, strong, nullable, readonly) NSMutableData *data;
@property (nonatomic, strong, nullable, readonly) NSError *error;

@property (nonatomic) CFAbsoluteTime initialResponseTime;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithRequest:(WorldSnakeRequest <WorldSnakeTaskDelegate> *)request NS_DESIGNATED_INITIALIZER;

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * _Nullable))completionHandler;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
