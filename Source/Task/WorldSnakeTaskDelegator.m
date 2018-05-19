//
//  WorldSnakeTaskDelegator.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/14.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeTaskDelegator.h"

#import "WorldSnakeSession.h"
#import "WorldSnakeRequest.h"
#import "WorldSnakeTaskConstructor.h"

@interface WorldSnakeTaskDelegator ()

@property (nonatomic, weak, nullable) WorldSnakeRequest <WorldSnakeTaskDelegate> *request;

@property (nonatomic, strong, nullable) NSMutableData *data;
@property (nonatomic, strong, nullable) NSError *error;

@end

@implementation WorldSnakeTaskDelegator

- (instancetype)initWithRequest:(WorldSnakeRequest <WorldSnakeTaskDelegate> *)request {
    if (self = [super init]) {
        _request = request;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"WorldSnakeTaskDelegator init error" reason:@"WorldSnakeTaskDelegator must be initialized with a request. Use the designated initializer to init." userInfo:nil];
    return [self initWithRequest:nil];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream * _Nullable))completionHandler {

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    self.error = error;
    XYWSSessionResponseDisposition disposition = XYWSSessionResponseFinished;
    WorldSnakeRequest <WorldSnakeTaskDelegate> *request = self.request;
    if (request) {
        [request task:task didFinishReceiveData:self.data];
        disposition = [request.session.taskConstructor didFinishReceiveData:self.data request:request error:error];
        [request task:task didCompleteWithError:error disposition:disposition];
    }
}


#pragma mark Getter

- (NSMutableData *)data {
    if (!_data) {
        _data = [NSMutableData new];
    } else if ([_data isKindOfClass:NSMutableData.class]) {
        _data = _data.mutableCopy;
    }
    return _data;
}

@end
