//
//  WSResponseSerialization.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/18.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WSResponseSerialization.h"

#import "WorldSnakeDataResult.h"

@implementation XYWSResponseSerializer

+ (XYWSResponseSerializer<WSResponseSerialization> *)serizlizer {
    static XYWSResponseSerializer<WSResponseSerialization> *serizlizer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serizlizer = XYWSResponseSerializer.new;
    });
    return serizlizer;
}

- (id _Nullable)serializeResponseWithDataTask:(NSURLSessionDataTask * _Nullable)dataTask data:(NSData *_Nullable)data resultClass:(Class _Nullable)klass error:(NSError * __autoreleasing *)error {
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length == 0 || isSpace) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
}

@end
