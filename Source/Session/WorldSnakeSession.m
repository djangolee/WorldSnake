//
//  WorldSnakeSession.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/8.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeSession.h"

#import "WSResponseSerialization.h"
#import "WorldSnakeDelegator.h"

#import "WorldSnakeDataRequest.h"
#import "WorldSnakeDownloadRequest.h"
#import "WorldSnakeUploadRequest.h"

#import "WorldSnakeTaskDelegator.h"
#import "WorldSnakeDataTaskDelegator.h"
#import "WorldSnakeTaskConstructor.h"

@interface WorldSnakeSession ()

@property (nonatomic, strong) NSURLSession *URLsession;
@property (nonatomic, copy) NSURLSessionConfiguration *configuration;
@property (nonatomic, strong) WorldSnakeDelegator *delegator;

@end

@implementation WorldSnakeSession

+ (WorldSnakeSession *)sharedSession {
    static WorldSnakeSession *sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *HTTPAdditionalHeaders = NSMutableDictionary.new;
        NSURLSessionConfiguration *configuration = NSURLSessionConfiguration.defaultSessionConfiguration.copy;
        for (NSURLQueryItem *header in XYWSHTTPDefaultHeads()) {
            [HTTPAdditionalHeaders setValue:header.value ? : @"" forKey:header.name ? : @""];
        }
        configuration.HTTPAdditionalHeaders = HTTPAdditionalHeaders;
        sharedSession = [[WorldSnakeSession alloc] initWithConfiguration:configuration];
    });
    return sharedSession;
}

#pragma mark Construction

- (instancetype)initWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration delegate:(id<WorldSnakeSessionDelegate> _Nullable)delegate {
    if (self = [super init]) {
        _startRequestsImmediately = YES;
        _delegator = [[WorldSnakeDelegator alloc] initWithSession:self];
        _delegator.delegate = delegate;
        _serializer = XYWSResponseSerializer.serizlizer;
        _taskConstructor = WorldSnakeTaskConstructor.new;
        _configuration = configuration ? : NSURLSessionConfiguration.defaultSessionConfiguration;
        _URLsession = [NSURLSession sessionWithConfiguration:_configuration delegate:_delegator delegateQueue:nil];
    }
    return self;
}
    
- (instancetype)initWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration {
    if (self = [self initWithConfiguration:configuration delegate:nil]) { }
    return self;
}

- (instancetype)init {
    if (self = [self initWithConfiguration:nil delegate:nil]) { }
    return self;
}

+ (WorldSnakeSession *)sessionWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration {
    return [[WorldSnakeSession alloc] initWithConfiguration:configuration];
}

+ (WorldSnakeSession *)sessionWithConfiguration:(NSURLSessionConfiguration * _Nullable)configuration delegate:(id<WorldSnakeSessionDelegate> _Nullable)delegate {
    return [[WorldSnakeSession alloc] initWithConfiguration:configuration delegate:delegate];
}

- (void)dealloc {
    [_URLsession invalidateAndCancel];
}

#pragma mark DataRequest

- (WorldSnakeDataRequest * _Nullable)requestWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    WorldSnakeDataRequest *request = [WorldSnakeDataRequest dataRequestWithSession:self URLRequest:URLRequest];
    if (self.startRequestsImmediately) {
        [request resume];
    }
    return request;
}

- (WorldSnakeDataRequest * _Nullable)requestWithURL:(id <WSEncodingURLConvertible>)URL {
    return [self requestWithURL:URL method:(WSHTTPGET) queryItems:nil headers:nil];
}

- (WorldSnakeDataRequest * _Nullable)requestWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers {
    NSURLRequest *URLRequest = [[NSMutableURLRequest alloc] initWithURL:URL method:method headers:headers];
    URLRequest = [WorldSnakeURLEncoding encode:URLRequest queryItems:queryItems];
    return [self requestWithURLRequest:URLRequest];
}

#pragma mark Download

- (WorldSnakeDownloadRequest * _Nullable)downloadWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    WorldSnakeDownloadRequest *request = [WorldSnakeDownloadRequest downloadRequestWithSession:self URLRequest:URLRequest];
    if (self.startRequestsImmediately) {
        [request resume];
    }
    return request;
}

- (WorldSnakeDownloadRequest * _Nullable)downloadWithURL:(id <WSEncodingURLConvertible>)URL {
    return [self downloadWithURL:URL method:(WSHTTPGET) queryItems:nil headers:nil];
}

- (WorldSnakeDownloadRequest * _Nullable)downloadWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers {
    NSURLRequest *URLRequest = [[NSMutableURLRequest alloc] initWithURL:URL method:method headers:headers];
    URLRequest = [WorldSnakeURLEncoding encode:URLRequest queryItems:queryItems];
    return [self downloadWithURLRequest:URLRequest];
}

#pragma mark Upload


- (WorldSnakeUploadRequest * _Nullable)uploadWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    WorldSnakeUploadRequest *request = [WorldSnakeUploadRequest uploadRequestWithSession:self URLRequest:URLRequest];
    if (self.startRequestsImmediately) {
        [request resume];
    }
    return request;
}

- (WorldSnakeUploadRequest * _Nullable)uploadWithURL:(id <WSEncodingURLConvertible>)URL {
    return [self uploadWithURL:URL method:(WSHTTPGET) queryItems:nil headers:nil];
}

- (WorldSnakeUploadRequest * _Nullable)uploadWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers {
    NSURLRequest *URLRequest = [[NSMutableURLRequest alloc] initWithURL:URL method:method headers:headers];
    URLRequest = [WorldSnakeURLEncoding encode:URLRequest queryItems:queryItems];
    return [self uploadWithURLRequest:URLRequest];
}

#pragma mark Getter

- (id<WorldSnakeSessionDelegate>)delegate {
    return self.delegator.delegate;
}

@end
