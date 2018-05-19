//
//  WorldSnakeDelegator.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeDelegator.h"

#import "WorldSnakeRequest.h"
#import "WorldSnakeSessionDelegate.h"

#import "WorldSnakeDataTaskDelegator.h"
#import "WorldSnakeDownloadTaskDelegator.h"
#import "WorldSnakeUploadTaskDelegator.h"

#import "NSURLSessionTask+WSAdding.h"

@interface WorldSnakeDelegator ()

@property (nonatomic, weak) WorldSnakeSession *session;

@end

@implementation WorldSnakeDelegator

#pragma mark Construction

- (instancetype)initWithSession:(WorldSnakeSession * _Nullable)session {
    if (self = [super init]) {
        _session = session;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"WorldSnakeDelegator init error" reason:@"WorldSnakeDelegator must be initialized with a request. Use the designated initializer to init." userInfo:nil];
    return [self initWithSession:nil];
}

#pragma mark NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:didBecomeInvalidWithError:)]) {
        [self.delegate URLSession:session didBecomeInvalidWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:didReceiveChallenge:completionHandler:)]) {
        [self.delegate URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
    }
}

- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSessionDidFinishEventsForBackgroundURLSession:)]) {
        [self.delegate URLSessionDidFinishEventsForBackgroundURLSession:session];
    }
}

#pragma mark NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {

    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:)]) {
        [self.delegate URLSession:session task:task willPerformHTTPRedirection:response newRequest:request completionHandler:completionHandler];
    } else if (completionHandler) {
        completionHandler(request);
    }
    
    WorldSnakeTaskDelegator *delegator = task.ws_master.delegator;
    if (delegator && [delegator respondsToSelector:@selector(URLSession:task:willPerformHTTPRedirection:newRequest:completionHandler:)]) {
        [delegator URLSession:session task:task willPerformHTTPRedirection:response newRequest:request completionHandler:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:didReceiveChallenge:completionHandler:)]) {
        [self.delegate URLSession:session task:task didReceiveChallenge:challenge completionHandler:completionHandler];
    }
    
    WorldSnakeTaskDelegator *delegator = task.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:task:didReceiveChallenge:completionHandler:)]) {
        [delegator URLSession:session task:task didReceiveChallenge:challenge completionHandler:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * _Nullable))completionHandler {

    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:needNewBodyStream:)]) {
        [self.delegate URLSession:session task:task needNewBodyStream:completionHandler];
    }
    
    WorldSnakeTaskDelegator *delegator = task.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:task:needNewBodyStream:)]) {
        [delegator URLSession:session task:task needNewBodyStream:completionHandler];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)]) {
        [self.delegate URLSession:session task:task didSendBodyData:bytesSent totalBytesSent:totalBytesSent totalBytesExpectedToSend:totalBytesExpectedToSend];
    }
    
    WorldSnakeUploadTaskDelegator *delegator = (WorldSnakeUploadTaskDelegator *)task.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend:)]) {
        [delegator URLSession:session task:task didSendBodyData:bytesSent totalBytesSent:totalBytesSent totalBytesExpectedToSend:totalBytesExpectedToSend];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didFinishCollectingMetrics:(NSURLSessionTaskMetrics *)metrics  API_AVAILABLE(ios(10.0)){
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:didFinishCollectingMetrics:)]) {
        [self.delegate URLSession:session task:task didFinishCollectingMetrics:metrics];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        [self.delegate URLSession:session task:task didCompleteWithError:error];
    }
    
    WorldSnakeRequest *request = task.ws_master;
    WorldSnakeTaskDelegator *delegator = request.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        [delegator URLSession:session task:task didCompleteWithError:error];
    }
    task.ws_master = nil;
}

#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:dataTask:didReceiveResponse:completionHandler:)]) {
        [self.delegate URLSession:session dataTask:dataTask didReceiveResponse:response completionHandler:completionHandler];
    } else {
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {

    if (self.delegate && [self respondsToSelector:@selector(URLSession:dataTask:didBecomeDownloadTask:)]) {
        [self.delegate URLSession:session dataTask:dataTask didBecomeDownloadTask:downloadTask];
    }
    
    WorldSnakeDataTaskDelegator *delegator = (WorldSnakeDataTaskDelegator *)dataTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:dataTask:didBecomeDownloadTask:)]) {
        [delegator URLSession:session dataTask:dataTask didBecomeDownloadTask:downloadTask];
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:dataTask:didReceiveData:)]) {
        [self.delegate URLSession:session dataTask:dataTask didReceiveData:data];
    }
    
    WorldSnakeDataTaskDelegator *delegator = (WorldSnakeDataTaskDelegator *)dataTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:dataTask:didReceiveData:)]) {
        [delegator URLSession:session dataTask:dataTask didReceiveData:data];
    }
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse * _Nullable))completionHandler {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:dataTask:willCacheResponse:completionHandler:)]) {
        [self.delegate URLSession:session dataTask:dataTask willCacheResponse:proposedResponse completionHandler:completionHandler];
    } else if (completionHandler) {
        completionHandler(proposedResponse);
    }
    
    WorldSnakeDataTaskDelegator *delegator = (WorldSnakeDataTaskDelegator *)dataTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:dataTask:willCacheResponse:completionHandler:)]) {
        [delegator URLSession:session dataTask:dataTask willCacheResponse:proposedResponse completionHandler:completionHandler];
    }
}

#pragma mark NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:downloadTask:didFinishDownloadingToURL:)]) {
        [self.delegate URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
    }
    
    WorldSnakeDownloadTaskDelegator *delegator = (WorldSnakeDownloadTaskDelegator *)downloadTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:downloadTask:didFinishDownloadingToURL:)]) {
        [delegator URLSession:session downloadTask:downloadTask didFinishDownloadingToURL:location];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
        [self.delegate URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
    }
    
    WorldSnakeDownloadTaskDelegator *delegator = (WorldSnakeDownloadTaskDelegator *)downloadTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:)]) {
        [delegator URLSession:session downloadTask:downloadTask didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    if (self.delegate && [self respondsToSelector:@selector(URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:)]) {
        [self.delegate URLSession:session downloadTask:downloadTask didResumeAtOffset:fileOffset expectedTotalBytes:expectedTotalBytes];
    }
    
    
    WorldSnakeDownloadTaskDelegator *delegator = (WorldSnakeDownloadTaskDelegator *)downloadTask.ws_master.delegator;
    
    if (delegator && [delegator respondsToSelector:@selector(URLSession:downloadTask:didResumeAtOffset:expectedTotalBytes:)]) {
        [delegator URLSession:session downloadTask:downloadTask didResumeAtOffset:fileOffset expectedTotalBytes:expectedTotalBytes];
    }
}

@end
