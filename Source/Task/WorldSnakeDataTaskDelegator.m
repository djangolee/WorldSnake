//
//  WorldSnakeDataTaskDelegator.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeDataTaskDelegator.h"

#import "WorldSnakeRequest.h"

@interface WorldSnakeDataTaskDelegator ()

@property (nonatomic, strong, nullable) NSProgress *progress;

@end

@implementation WorldSnakeDataTaskDelegator

- (instancetype)initWithRequest:(WorldSnakeRequest<WorldSnakeTaskDelegate> *)request {
    if (self = [super initWithRequest:request]) {
        _progress = [NSProgress progressWithTotalUnitCount:0];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    if (self.initialResponseTime <= 0) {
        self.initialResponseTime = CFAbsoluteTimeGetCurrent();
    }
    [self.data appendData:data];
    
    self.progress.totalUnitCount = dataTask.response.expectedContentLength;
    self.progress.completedUnitCount = self.data.length;
    WorldSnakeRequest <WorldSnakeTaskDelegate> *request = self.request;
    if (request) {
        [request task:dataTask didReceiveProgress:self.progress];
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    
}

@end
