//
//  WorldSnakeDataTaskDelegator.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeTaskDelegator.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WorldSnakeDataTaskDelegate <WorldSnakeTaskDelegate>

@end

@interface WorldSnakeDataTaskDelegator : WorldSnakeTaskDelegator

@property (nonatomic, strong, nullable, readonly) NSProgress *progress;

#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler;

@end

NS_ASSUME_NONNULL_END
