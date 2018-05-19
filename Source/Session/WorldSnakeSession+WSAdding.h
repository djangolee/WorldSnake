//
//  WorldSnakeSession+WSAdding.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/16.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeSession.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorldSnakeSession (WSAdding)

@property (class, nonatomic, copy, readonly) WorldSnakeDataRequest * _Nullable (^dataURL)(id <WSEncodingURLConvertible>);
@property (class, nonatomic, copy, readonly) WorldSnakeDataRequest * _Nullable (^dataRequest)(id <WSEncodingURLRequestConvertible>);

@property (class, nonatomic, copy, readonly) WorldSnakeDownloadRequest * _Nullable (^downloadURL)(id <WSEncodingURLConvertible>);
@property (class, nonatomic, copy, readonly) WorldSnakeDownloadRequest * _Nullable (^downloadRequest)(id <WSEncodingURLRequestConvertible>);

@property (class, nonatomic, copy, readonly) WorldSnakeUploadRequest * _Nullable (^uploadURL)(id <WSEncodingURLConvertible>);
@property (class, nonatomic, copy, readonly) WorldSnakeUploadRequest * _Nullable (^uploadRequest)(id <WSEncodingURLRequestConvertible>);


@property (nonatomic, copy, readonly) WorldSnakeDataRequest * _Nullable (^dataURL)(id <WSEncodingURLConvertible>);
@property (nonatomic, copy, readonly) WorldSnakeDataRequest * _Nullable (^dataRequest)(id <WSEncodingURLRequestConvertible>);

@property (nonatomic, copy, readonly) WorldSnakeDownloadRequest * _Nullable (^downloadURL)(id <WSEncodingURLConvertible>);
@property (nonatomic, copy, readonly) WorldSnakeDownloadRequest * _Nullable (^downloadRequest)(id <WSEncodingURLRequestConvertible>);

@property (nonatomic, copy, readonly) WorldSnakeUploadRequest * _Nullable (^uploadURL)(id <WSEncodingURLConvertible>);
@property (nonatomic, copy, readonly) WorldSnakeUploadRequest * _Nullable (^uploadRequest)(id <WSEncodingURLRequestConvertible>);

@end

NS_ASSUME_NONNULL_END
