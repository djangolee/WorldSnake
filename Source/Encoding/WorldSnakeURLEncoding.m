//
//  WorldSnakeURLEncoding.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/9.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WorldSnakeURLEncoding.h"

#import "WSURLComponents.h"

#import <WorldSnake/WorldSnake.h>
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

NSString * NSStringFromWSHTTPMethod(WSHTTPMethod method) {
    switch (method) {
        case WSHTTPOptions:
            return @"OPTIONS";
        case WSHTTPGET:
            return @"GET";
        case WSHTTPHEAD:
            return @"HEAD";
        case WSHTTPPOST:
            return @"POST";
        case WSHTTPPUT:
            return @"PUT";
        case WSHTTPPATCH:
            return @"PATCH";
        case WSHTTPDELETE:
            return @"DELETE";
        case WSHTTPTrace:
            return @"TRACE";
        case WSHTTPConnect:
            return @"CONNECT";
        default:
            return @"GET";
    }
}

NSArray <NSURLQueryItem *> * WSArraySortCompactFromArray(NSArray <NSURLQueryItem *> * items) {
    NSMutableArray <NSURLQueryItem *> * asItems = NSMutableArray.new;
    NSMutableSet<NSString *> *names = NSMutableSet.new;
    for (NSURLQueryItem *item in items.reverseObjectEnumerator) {
        if (![names containsObject:item.name]) {
            [names addObject:item.name];
            [asItems addObject:item];
        }
    }
    [asItems sortUsingComparator:^NSComparisonResult(NSURLQueryItem * _Nonnull item1, NSURLQueryItem *  _Nonnull item2) {
        return [item1.name compare:item2.name];
    }];
    return asItems.copy;
}

BOOL WSQueryItemsEqualToQueryItems(NSArray <NSURLQueryItem *> * items1, NSArray <NSURLQueryItem *> * items2) {
    if (!items1 || !items2) return NO;
    if (items1.count != items2.count) return NO;
    int index = 0;
    for (NSURLQueryItem *item1 in items1) {
        NSURLQueryItem *item2 = items2[index];
        if (![item1.name isEqualToString:item2.name] || ![item1.value isEqualToString:item2.value]) {
            return NO;
        }
        index ++;
    }
    return YES;
}

NSArray <NSURLQueryItem *> * XYArrayRemoveWithName(NSArray <NSURLQueryItem *> *array, NSString *name) {
    NSMutableArray *items = array.mutableCopy;
    for (NSURLQueryItem *item in array) {
        if ([item.name isEqualToString:name]) {
            [items removeObject:item];
        }
    }
    return items.copy;
}

BOOL WSHTTPMethodIsQueryMethod(NSString *methodString) {
    static NSSet <NSString *> *URIQueryMethods = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!URIQueryMethods) URIQueryMethods = [NSSet setWithArray:@[@"GET", @"HEAD", @"DELETE"]];
    });
    return [URIQueryMethods containsObject:methodString.uppercaseString];
}

WSHTTPMethod WSHTTPMethodFromeMethod(NSString *methodString) {
    NSString *method = methodString.uppercaseString;
    if ([method isEqualToString:@"OPTIONS"]) {
        return WSHTTPOptions;
    } else if ([method isEqualToString:@"GET"]) {
        return WSHTTPGET;
    } else if ([method isEqualToString:@"HEAD"]) {
        return WSHTTPHEAD;
    } else if ([method isEqualToString:@"POST"]) {
        return WSHTTPPOST;
    } else if ([method isEqualToString:@"PUT"]) {
        return WSHTTPPUT;
    } else if ([method isEqualToString:@"PATCH"]) {
        return WSHTTPPATCH;
    } else if ([method isEqualToString:@"DELETE"]) {
        return WSHTTPDELETE;
    } else if ([method isEqualToString:@"TRACE"]) {
        return WSHTTPTrace;
    } else if ([method isEqualToString:@"CONNECT"]) {
        return WSHTTPConnect;
    } else {
        return WSHTTPGET;
    }
}

NSArray <NSURLQueryItem *> * _Nullable XYWSHTTPDefaultHeads() {
    static NSArray *defaultHeads = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // accept encoding
        NSString *acceptEncoding = @"gzip;q=1.0, compress;q=0.5";
        
        // accep language
        NSMutableArray *acceptLanguagesComponents = NSMutableArray.new;
        [[NSLocale preferredLanguages] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            float q = 1.0f - (idx * 0.1f);
            [acceptLanguagesComponents addObject:[NSString stringWithFormat:@"%@;q=%0.1g", obj, q]];
            *stop = q <= 0.5f;
        }];
        NSString *acceptLanguages = [acceptLanguagesComponents componentsJoinedByString:@", "];
        
        // user agent eg: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15
        
        NSMutableString *userAgent = NSMutableString.new;
        NSBundle *mainBundle = NSBundle.mainBundle;
        NSDictionary *infoDictionary = mainBundle.infoDictionary;
        
        NSString *displayName = infoDictionary[@"CFBundleDisplayName"];
        NSString *versionName = infoDictionary[@"CFBundleShortVersionString"];
        NSString *buildName = infoDictionary[(__bridge NSString *)kCFBundleVersionKey];
        if (!displayName) displayName = infoDictionary[(__bridge NSString *)kCFBundleExecutableKey] ? : infoDictionary[(__bridge NSString *)kCFBundleIdentifierKey];
        
        struct utsname device;
        uname(&device);
        NSString *machine = [NSString stringWithCString:device.machine encoding:NSUTF8StringEncoding];
        NSString *scale = [NSString stringWithFormat:@"%0.2f", UIScreen.mainScreen.scale];
        NSString *resolution = [NSString stringWithFormat:@"%0.f*%0.f", CGRectGetWidth(UIScreen.mainScreen.bounds) * UIScreen.mainScreen.scale, CGRectGetHeight(UIScreen.mainScreen.bounds)  * UIScreen.mainScreen.scale];
        
        NSString *modelName = UIDevice.currentDevice.model;
        NSString *systemName = UIDevice.currentDevice.systemName;
        NSString *systemVersion = UIDevice.currentDevice.systemVersion;

        NSDictionary *urlsessioninfo = [NSBundle bundleForClass:NSURLSession.class].infoDictionary;
        NSString *urlsessionBuild = urlsessioninfo[@"CFBundleShortVersionString"];
        NSString *urlsessionName = urlsessioninfo[(__bridge NSString *)kCFBundleExecutableKey];
        
        NSDictionary *worldsnakeinfo = [NSBundle bundleForClass:WorldSnakeSession.class].infoDictionary;
        NSString *worldsnakeBuild = worldsnakeinfo[@"CFBundleShortVersionString"];
        NSString *worldsnakeName = worldsnakeinfo[(__bridge NSString *)kCFBundleExecutableKey];

        [userAgent appendFormat:@"%@/%@ (%@; %@ %@ %@)", displayName, versionName, modelName, machine, systemName, systemVersion];
        [userAgent appendFormat:@" Screen/%@ (%@) Version/%@ Build/%@", scale, resolution, versionName, buildName];
        [userAgent appendFormat:@" %@/%@", urlsessionName, urlsessionBuild];
        [userAgent appendFormat:@" %@/%@", worldsnakeName, worldsnakeBuild];
        
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        
        // connection
        NSString *connection = @"Keep-Alive";
        
        // Content-Type
        NSString *contentType = @"application/json";
        
        defaultHeads = @[[NSURLQueryItem queryItemWithName:@"Accept-Encoding" value:acceptEncoding],
                         [NSURLQueryItem queryItemWithName:@"Accept-Language" value:acceptLanguages],
                         [NSURLQueryItem queryItemWithName:@"User-Agent" value:userAgent],
                         [NSURLQueryItem queryItemWithName:@"Connection" value:connection],
                         [NSURLQueryItem queryItemWithName:@"Content-Type" value:contentType]];
    });
    return defaultHeads;
}

@implementation NSString (WorldSnakeEncoding)

- (NSURL *)asURL {
    NSURL *asURL = [NSURL URLWithString:self];
    if (!asURL) {
        NSString *UTF8String = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        asURL = [NSURL URLWithString:UTF8String];
    }
    return asURL;
}

@end

@implementation NSURL (WorldSnakeEncoding)

- (NSURL *)asURL {
    return self;
}

@end

@implementation NSURLComponents (WorldSnakeEncoding)

- (NSURL *)asURL {
    return self.URL;
}

@end

@implementation NSURLRequest (WorldSnakeEncoding)

- (NSURLRequest *)asURLRequest {
    return self;
}

@end

@implementation NSMutableURLRequest (WorldSnakeEncoding)

- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method headers:(NSArray <NSURLQueryItem *> *)headers {
    NSURL *asURL = URL.asURL;
    self = [self initWithURL:asURL];
    if (asURL && self) {
        self.HTTPMethod = NSStringFromWSHTTPMethod(method);
        NSURLComponents *URLComponents = NSURLComponents.new;
        for (NSURLQueryItem *item in headers) {
            URLComponents.queryItems = @[item];
            NSArray *array = [URLComponents.percentEncodedQuery componentsSeparatedByString:@"="];
            if (array.count == 2) {
                [self setValue:array.lastObject forHTTPHeaderField:array.firstObject];
            }
        }
    }
    return self;
}

@end

@implementation WorldSnakeURLEncoding

+ (NSURLRequest *)encode:(id<WSEncodingURLRequestConvertible>)URLRequest queryItems:(NSArray<NSURLQueryItem *> *)queryItems {
    NSMutableURLRequest *asURLRequest = URLRequest.asURLRequest.mutableCopy;
    NSURL *asURL = asURLRequest.URL;
    NSURLComponents *URLComponents = [NSURLComponents componentsWithURL:asURL resolvingAgainstBaseURL:YES];
    
    if (queryItems.count <= 0) return asURLRequest;
    if (!asURL) return asURLRequest;
    if (!URLComponents) return asURLRequest;
    
    URLComponents.queryItems = [URLComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:queryItems];
    
    if (WSHTTPMethodIsQueryMethod(asURLRequest.HTTPMethod ? : @"GET")) {
        asURLRequest.URL = URLComponents.URL;
    } else {
        if (!asURLRequest.allHTTPHeaderFields[@"Content-Type"]) {
            [asURLRequest setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        }
        asURLRequest.HTTPBody = [URLComponents.percentEncodedQuery dataUsingEncoding:NSUTF8StringEncoding];
    }
    return asURLRequest;
}

@end


