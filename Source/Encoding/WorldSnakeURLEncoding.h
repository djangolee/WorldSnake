//
//  WorldSnakeURLEncoding.h
//  WorldSnake
//
//  Created by Panghu on 2018/5/9.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WSHTTPMethod) {
    WSHTTPOptions   = 0,
    WSHTTPGET       = 1,
    WSHTTPHEAD      = 2,
    WSHTTPPOST      = 3,
    WSHTTPPUT       = 4,
    WSHTTPPATCH     = 5,
    WSHTTPDELETE    = 6,
    WSHTTPTrace     = 7,
    WSHTTPConnect   = 8
};

@class WSURLComponents;

extern NSString * NSStringFromWSHTTPMethod(WSHTTPMethod method);
extern NSArray <NSURLQueryItem *> * WSArraySortCompactFromArray(NSArray <NSURLQueryItem *> * items);
extern BOOL WSQueryItemsEqualToQueryItems(NSArray <NSURLQueryItem *> * items1, NSArray <NSURLQueryItem *> * items2);
extern NSArray <NSURLQueryItem *> * XYArrayRemoveWithName(NSArray <NSURLQueryItem *> *array, NSString *name);
extern BOOL WSHTTPMethodIsQueryMethod(NSString *methodString);
extern WSHTTPMethod WSHTTPMethodFromeMethod(NSString *methodString);
extern NSArray <NSURLQueryItem *> * _Nullable XYWSHTTPDefaultHeads(void);

@protocol WSEncodingURLConvertible <NSObject>

- (NSURL * _Nullable)asURL;

@end

@protocol WSEncodingURLRequestConvertible <NSObject>

- (NSURLRequest * _Nullable)asURLRequest;

@end

@protocol WSQueryEncoding <NSObject>

+ (NSURLRequest * _Nullable)encode:(id <WSEncodingURLRequestConvertible>)URLRequest queryItems:(NSArray <NSURLQueryItem *> *)queryItems;

@end

@interface NSString (WorldSnakeEncoding) <WSEncodingURLConvertible>

@end

@interface NSURL (WorldSnakeEncoding) <WSEncodingURLConvertible>

@end

@interface NSURLComponents (WorldSnakeEncoding) <WSEncodingURLConvertible>

@end

@interface NSURLRequest (WorldSnakeEncoding) <WSEncodingURLRequestConvertible>

@end

@interface NSMutableURLRequest (WorldSnakeEncoding)

- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method headers:(NSArray <NSURLQueryItem *> *)headers;

@end

@interface WorldSnakeURLEncoding : NSObject <WSQueryEncoding>

@end

NS_ASSUME_NONNULL_END
