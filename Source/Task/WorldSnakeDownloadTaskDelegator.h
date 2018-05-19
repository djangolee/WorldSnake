//
//  WorldSnakeDownloadTaskDelegator.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/15.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeTaskDelegator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorldSnakeDownloadTaskDelegator : WorldSnakeTaskDelegator

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location;
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes;

@end

NS_ASSUME_NONNULL_END
