//
//  WSResponseSerialization.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/18.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WorldSnakeDataResult;

@protocol WSResponseSerialization

@optional

- (id _Nullable)serializeResponseWithDataTask:(NSURLSessionDataTask * _Nullable)dataTask data:(NSData *_Nullable)data resultClass:(Class _Nullable)klass error:(NSError * __autoreleasing *)error;

@end

// ResultAttribute
// Data

@protocol WorldSnakeDataResultAttribute

@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^resultClass)(Class klass);
@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^scheduling)(dispatch_queue_t queue);
@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^serizlization)(id <WSResponseSerialization> serizlization);

@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^progress)(void (NS_NOESCAPE ^)(NSProgress *progress));
@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^success)(void (NS_NOESCAPE ^)(NSURLSessionDataTask *task, WorldSnakeDataResult * _Nullable result));
@property (nonatomic, copy, readonly) id <WorldSnakeDataResultAttribute> (^failure)(void (NS_NOESCAPE ^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error));

@end

// Down

@protocol WorldSnakeDownloadResultAttribute

@end

@interface XYWSResponseSerializer : NSObject <WSResponseSerialization>

@property (class, nonatomic, strong, readonly) XYWSResponseSerializer <WSResponseSerialization> *serizlizer;

@end
