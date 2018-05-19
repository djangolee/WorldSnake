//
//  WorldSnakeRequest.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/8.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeRequest.h"

#import "NSURLSessionTask+WSAdding.h"

#import "WorldSnakeSession.h"
#import "WSURLComponents.h"

#import "WorldSnakeDataTaskDelegator.h"
#import "WorldSnakeDownloadTaskDelegator.h"
#import "WorldSnakeUploadTaskDelegator.h"

#import "WorldSnakeDataRequest.h"
#import "WorldSnakeDownloadRequest.h"
#import "WorldSnakeUploadRequest.h"

#import "NSError+WSAdding.h"
#import "WorldSnakeMacro.h"

@interface WorldSnakeRequest () <WorldSnakeTaskDelegate>

@property (nonatomic, strong) NSOperationQueue *queue;

@property (nonatomic, strong) WorldSnakeSession *session;
@property (nonatomic, strong, nullable) id <WSEncodingURLRequestConvertible> URLRequestConvertible;

@property (nonatomic) uint retryCount;

@property (nonatomic) WorldSnakeRequestState state;
@property (nonatomic) WorldSnakeRequestTimeline timeline;

@property (nonatomic, copy, nullable) NSData  *data;
@property (nonatomic, copy, nullable) NSError  *error;
@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic, strong) WorldSnakeTaskDelegator *delegator;

@property (nonatomic, strong) NSLock *taskLock;

@end

@implementation WorldSnakeRequest

@synthesize task = _task, taskLock = _taskLock, delegator = _delegator;

#pragma mark Constructor

+ (WorldSnakeDataRequest *)dataRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [[WorldSnakeDataRequest alloc] initWithSession:session URLRequest:URLRequest];
}

+ (WorldSnakeDownloadRequest *)downloadRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [[WorldSnakeDownloadRequest alloc] initWithSession:session URLRequest:URLRequest];
}

+ (WorldSnakeUploadRequest *)uploadRequestWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    return [[WorldSnakeUploadRequest alloc] initWithSession:session URLRequest:URLRequest];
}

- (instancetype)initWithSession:(WorldSnakeSession *)session URLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    if (self = [super init]) {
        _session = session;
        _URLRequestConvertible = URLRequest;
        _maxRetryCount = 1;
        _taskLock = NSLock.new;
        _queue = NSOperationQueue.new;
        _queue.maxConcurrentOperationCount = 1;
        _queue.qualityOfService = NSQualityOfServiceUtility;
        _queue.name = [NSString stringWithFormat:@"com.xyworldsnak.request-thred-%p", self];
        [self setupTask];
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"WorldSnakeRequest init error" reason:@"WorldSnakeRequest must be initialized with a request. Use the designated initializer to init." userInfo:nil];
    return [self initWithSession:nil URLRequest:nil];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

// Public

- (void)resume {
    [self.queue addOperationWithBlock:^{
        NSURLSessionTask *task = self.task;
        if (task.state == NSURLSessionTaskStateSuspended) {
            task.ws_master = self;
            [task resume];
            if (self.timeline.startTime == 0) {
                WorldSnakeRequestTimeline timeline = self.timeline;
                timeline.startTime = CFAbsoluteTimeGetCurrent();
                self.timeline = timeline;
            }
        }
    }];
}

- (void)suspend {
    [self.queue addOperationWithBlock:^{
        [self.task suspend];
    }];
}

- (void)cancel {
    [self.queue addOperationWithBlock:^{
        [self.task cancel];
    }];
}

- (void)setupTask {
    [self.queue addOperationWithBlock:^{
        NSError *error = nil;
        WorldSnakeRequestState state = self.state == WorldSnakeRequestRetry ? WorldSnakeRequestRetry : WorldSnakeRequestInitial;
        NSURLSessionTask *task = nil;
        WorldSnakeTaskDelegator *delegator = nil;
        WorldSnakeSession *session = self.session;
        NSString *selectString = nil;
        if ([self isKindOfClass:WorldSnakeDataRequest.class]) {
            delegator = [[WorldSnakeDataTaskDelegator alloc] initWithRequest:self];
            task = [session.taskConstructor dataTaskWithSession:session.URLsession request:(WorldSnakeDataRequest *)self URLRequest:self.URLRequestConvertible];
            selectString = NSStringFromSelector(@selector(dataTaskWithSession:request:URLRequest:));
        } else if ([self isKindOfClass:WorldSnakeDownloadRequest.class]) {
            delegator = [[WorldSnakeDownloadTaskDelegator alloc] initWithRequest:self];
            task = [session.taskConstructor downloadTaskWithSession:session.URLsession request:(WorldSnakeDownloadRequest *)self URLRequest:self.URLRequestConvertible];
            selectString = NSStringFromSelector(@selector(downloadTaskWithSession:request:URLRequest:));
        } else if ([self isKindOfClass:WorldSnakeUploadRequest.class]) {
            delegator = [[WorldSnakeUploadTaskDelegator alloc] initWithRequest:self];
            task = [session.taskConstructor uploadTaskWithSession:session.URLsession request:(WorldSnakeUploadRequest *)self URLRequest:self.URLRequestConvertible];
            selectString = NSStringFromSelector(@selector(uploadTaskWithSession:request:URLRequest:));
        }
        
        [self.taskLock lock];
        if (task && delegator) {
            self->_delegator = delegator;
            self->_task = task;
            error = nil;
        } else {
            self->_delegator = nil;
            self->_task = nil;
            state = WorldSnakeRequestInitialFailure;
            error = [NSError errorWithWSErrorCode:WorldSnakeErrorTaskInitialFailure reason:[NSString stringWithFormat:@"** <WorldSnakeTaskConvertible> %@ 这里可能出现问题了", selectString]];
        }
        [self.taskLock unlock];
        
        [self _didCompleteWithState:state task:self.task error:error];
    }];
}

- (void)didReceiveProgress:(NSProgress *)progress {  }

- (void)_didReceiveProgress:(NSProgress *)progress {
    [self didReceiveProgress:progress];
}

- (void)didCompleteWithState:(WorldSnakeRequestState)state task:(NSURLSessionTask *)task error:(NSError *)error { }

- (void)_didCompleteWithState:(WorldSnakeRequestState)state task:(NSURLSessionTask *)task error:(NSError *)error {
    self.state = state;
    self.error = error;
    
    [self didCompleteWithState:self.state task:task error:error];
    
    if (state == WorldSnakeRequestRetry) {
        [self setupTask];
        [self resume];
    }
}

#pragma mark WorldSnakeTaskDelegate

- (void)task:(nonnull NSURLSessionTask *)task didReceiveProgress:(nonnull NSProgress *)progress {
    [self _didReceiveProgress:progress];
}

- (void)task:(nonnull NSURLSessionTask *)task didFinishReceiveData:(nonnull NSData *)data {
    WorldSnakeRequestTimeline timeline = self.timeline;
    timeline.endTime = CFAbsoluteTimeGetCurrent();
    timeline.initialResponseTime = self.delegator.initialResponseTime;
    self.timeline = timeline;
    self.data = data;
}

- (void)task:(nonnull NSURLSessionTask *)task didCompleteWithError:(NSError *)error disposition:(XYWSSessionResponseDisposition)disposition {
    NSError *stateError = nil;
    WorldSnakeRequestState state = WorldSnakeRequestInitial;
    static NSString *selectString = @"-didFinishReceiveData:request:error:";
    
    if (disposition == XYWSSessionResponseCancel) {
        state = WorldSnakeRequestCancel;
        stateError = [NSError errorWithWSErrorCode:WorldSnakeErrorResponseCancel reason:[NSString stringWithFormat:@"** <WorldSnakeTaskConvertible> %@ return is XYWSSessionResponseCancel", selectString]];
    } else if (disposition == XYWSSessionResponseFinished) {
        state = WorldSnakeRequestFinish;
    } else if (disposition == XYWSSessionResponseRetry) {
        if (self.retryCount < self.maxRetryCount) {
            state = WorldSnakeRequestMaxRetryFinish;
            stateError = [NSError errorWithWSErrorCode:WorldSnakeErrorResponseCancel reason:[NSString stringWithFormat:@"** <WorldSnakeTaskConvertible> %@ return is WorldSnakeRequestRetry and retry count is %d", selectString, (int)self.retryCount]];
        } else {
            self.retryCount ++;
            state = WorldSnakeRequestRetry;
        }
    } else {
        state = WorldSnakeRequestUnknow;
        stateError = [NSError errorWithWSErrorCode:WorldSnakeErrorResponseCancel reason:[NSString stringWithFormat:@"** <WorldSnakeTaskConvertible> %@ return is not XYWSSessionResponseDisposition", selectString]];
    }
    [self _didCompleteWithState:state task:task error:WSErrorWithUnderlyingError(stateError, error)];
}

- (NSURLSessionTask *)task {
    [self.taskLock lock];
    @defer_xyws {
        [self.taskLock unlock];
    };
    return _task;
}

- (WorldSnakeTaskDelegator *)delegator {
    [self.taskLock lock];
    @defer_xyws {
        [self.taskLock unlock];
    };
    return _delegator;
}

@end
