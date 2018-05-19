//
//  WorldSnakeResult.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/16.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeResult.h"

#import "WorldSnakeRequest.h"

@interface WorldSnakeResult ()

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong, nullable) NSData  *data;
@property (nonatomic, copy, nullable) NSError  *error;
@property (nonatomic, copy, nullable) NSURLSessionTask *task;
@property (nonatomic, copy, nullable) NSURLRequest  *request;
@property (nonatomic, copy, nullable) NSURLResponse *response;

@property (nonatomic) WorldSnakeRequestTimeline timeline;

@end

@implementation WorldSnakeResult

- (instancetype)initWithRequest:(WorldSnakeRequest *)request responseObject:(id _Nullable)responseObject {
    if (self = [super init]) {
        _responseObject = responseObject;
        _data = request.data;
        _error = request.error;
        _task = request.task;
        _request = _task.originalRequest;
        _response = _task.response;
        _timeline = request.timeline;
    }
    return self;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"WorldSnakeResult init error" reason:@"WorldSnakeResult must be initialized with a request. Use the designated initializer to init." userInfo:nil];
    return [self initWithRequest:nil responseObject:nil];
}

- (NSString *)description {
    NSMutableString *description = NSMutableString.new;
    [description appendFormat:@"<%@ %p> {\n", NSStringFromClass(self.class), self];
    [description appendFormat:@"\tresponseObject = %@\n", self.responseObject];
    [description appendFormat:@"\ttimeline = {start: %f, end: %f, initialresponse: %f}\n", self.timeline.startTime, self.timeline.endTime, self.timeline.initialResponseTime];
    [description appendFormat:@"\terror = %@\n", self.error];
    [description appendFormat:@"\ttask = %@\n", self.task];
    [description appendFormat:@"\trequest = %@\n", self.request];
    [description appendFormat:@"\tresponse = %@\n", self.response];
    [description appendString:@"}"];
    return description.copy;
}

- (NSString *)debugDescription {
    return [self description];
}

@end
