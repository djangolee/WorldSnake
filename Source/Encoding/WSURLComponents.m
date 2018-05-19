//
//  WSURLComponents.m
//  WorldSnake
//
//  Created by Panghu on 2018/5/11.
//  Copyright © 2018 Panghu. All rights reserved.
//

#import "WSURLComponents.h"

@interface WSURLComponents ()

@property (nonatomic, strong) NSURLComponents *URLComponents;
@property (nonatomic, strong) NSURLComponents *URLHeadComponents;
@property (nonatomic) WSHTTPMethod method;

@property (nonatomic, strong) NSString *compactQueryString;
@property (nonatomic, strong) NSString *compactHeadString;

@end

@implementation WSURLComponents

#pragma mark Constructor

- (instancetype)initWithURLRequest:(id <WSEncodingURLRequestConvertible>)URLRequest {
    if (self = [self init]) {
        if ([URLRequest isKindOfClass:self.class]) {
            WSURLComponents *URLComponents = (WSURLComponents *)URLRequest;
            _URLComponents = URLComponents.URLComponents.copy;
            _URLHeadComponents = URLComponents.URLHeadComponents.copy;
            _method = URLComponents.method;
        } else {
            NSURLRequest *asURLRequest = URLRequest.asURLRequest;
            if (asURLRequest) {
                _method = WSHTTPMethodFromeMethod(asURLRequest.HTTPMethod);
                _URLComponents = asURLRequest.URL ? [NSURLComponents componentsWithURL:asURLRequest.URL resolvingAgainstBaseURL:YES] : NSURLComponents.new;
                _URLHeadComponents = NSURLComponents.new;
                
                if (!WSHTTPMethodIsQueryMethod(asURLRequest.HTTPMethod ? : @"GET") && asURLRequest.HTTPBody) {
                    NSString *query = [[NSString alloc] initWithData:asURLRequest.HTTPBody encoding:NSUTF8StringEncoding];
                    _URLComponents.percentEncodedQuery = [_URLComponents.percentEncodedQuery ? : @"" stringByAppendingFormat:@"%@%@", _URLComponents.percentEncodedQuery.length > 0 ? @"&" : @"", query];
                }
                if (asURLRequest.allHTTPHeaderFields.count > 0) {
                    NSMutableArray <NSURLQueryItem *> *headers = NSMutableArray.new;
                    [asURLRequest.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
                        [headers addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
                    }];
                    _URLHeadComponents.queryItems =headers;
                }
            }
        }
    }
    return self;
}

- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL {
    return [self initWithURL:URL method:(WSHTTPGET) queryItems:nil headers:nil];
}

- (instancetype)initWithURL:(id <WSEncodingURLConvertible>)URL method:(WSHTTPMethod)method queryItems:(NSArray <NSURLQueryItem *> * _Nullable)queryItems headers:(NSArray <NSURLQueryItem *> * _Nullable)headers {
    if (self = [self init]) {
        _method = method;
        _URLComponents= [NSURLComponents componentsWithURL:URL.asURL resolvingAgainstBaseURL:YES];
        _URLHeadComponents = NSURLComponents.new;
        if (queryItems.count > 0) {
            _URLComponents.queryItems = [_URLComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:queryItems];;
        }
        if (headers.count > 0) {
            _URLHeadComponents.queryItems = [_URLComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:headers];
        }
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _method = WSHTTPGET;
    }
    return self;
}

#pragma WSEncodingURLRequestConvertible

- (NSURLRequest * _Nullable)asURLRequest {
    [self compactHead];
    [self compactQuery];
    
    NSURLRequest *URLRequest = [[NSMutableURLRequest alloc] initWithURL:self.URLComponents.URL method:self.method headers:self.URLHeadComponents.queryItems];
    URLRequest = [WorldSnakeURLEncoding encode:URLRequest queryItems:self.URLComponents.queryItems];
    return URLRequest;
}

#pragma mark Public methods

- (void)compactQuery {
    if (![self.compactQueryString isEqualToString:self.URLComponents.query]) {
        self.URLComponents.queryItems = WSArraySortCompactFromArray(self.URLComponents.queryItems);
        self.compactQueryString = self.URLComponents.query;
    }
}

- (void)compactHead {
    if (![self.compactHeadString isEqualToString:self.URLHeadComponents.query]) {
        self.URLHeadComponents.queryItems = WSArraySortCompactFromArray(self.URLHeadComponents.queryItems);
        self.compactHeadString = self.URLHeadComponents.query;
    }
}

// Operation


- (void)setURL:(id<WSEncodingURLConvertible>)URL {
    NSURLComponents *URLComponents= [NSURLComponents componentsWithURL:URL.asURL resolvingAgainstBaseURL:YES];
    self.URLComponents.scheme = URLComponents.scheme;
    self.URLComponents.host = URLComponents.host;
    self.URLComponents.port = URLComponents.port;
    self.URLComponents.path = URLComponents.path;
    
    if (URLComponents.user) {
        self.URLComponents.user = URLComponents.user;
    }
    if (URLComponents.password) {
        self.URLComponents.user = URLComponents.password;
    }
    if (URLComponents.queryItems.count > 0) {
        self.URLComponents.queryItems = [self.URLComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:URLComponents.queryItems];
    }
}

- (void)setHTTPMethod:(WSHTTPMethod)HTTPMethod {
    self.method = HTTPMethod;
}

- (void)setScheme:(NSString * _Nullable)scheme {
    self.URLComponents.scheme = scheme;
}

- (void)setUser:(NSString * _Nullable)user {
    self.URLComponents.user = user;
}

- (void)setPassword:(NSString * _Nullable)password {
    self.URLComponents.password = password;
}

- (void)setHost:(NSString * _Nullable)host {
    self.URLComponents.host = host;
}

- (void)setPort:(NSNumber * _Nullable)port {
    self.URLComponents.port = port;
}

- (void)setPath:(NSString * _Nullable)path {
    self.URLComponents.path = path;
}

- (void)setPattern:(NSString * _Nullable)pattern keys:(NSArray <NSString *> * _Nullable)keys {
    int key_index = 0;
    int index = 0;
    NSArray<NSString *> *items = [pattern componentsSeparatedByString:@"/"];
    NSMutableArray<NSString *> *patterns = items.mutableCopy;
    for (NSString *item in items) {
        if (key_index >= keys.count) {
            break;
        }
        if ([item hasPrefix:@":"] && key_index < keys.count) {
            patterns[index] = keys[key_index];
            key_index ++;
        }
        index ++;
    }
    [self setPath:[patterns componentsJoinedByString:@"/"]];
}

- (void)addingHeader:(NSURLQueryItem *)item {
    if (!item) {
        NSAssert(NO, @"*** -[WSURLComponents addingHeader:]: nil head parameter");
        return;
    }
    self.URLHeadComponents.queryItems = [self.URLHeadComponents.queryItems ? : @[] arrayByAddingObject:item];
}

- (void)addingHeaders:(NSArray <NSURLQueryItem *> *)items {
    if (!items) {
        NSAssert(NO, @"*** -[WSURLComponents addingHeaders:]: nil heads parameter");
        return;
    }
    self.URLHeadComponents.queryItems = [self.URLHeadComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:items];
}

- (void)appendingQuery:(NSString *)query {
    if (!query) {
        NSAssert(NO, @"*** -[WSURLComponents appendingQuery:]: nil argument");
        return;
    }
    if (query.length <= 0) {
        return;
    }
    self.URLComponents.query = [self.URLComponents.query ? : @"" stringByAppendingFormat:@"%@%@", self.URLComponents.query.length > 0 ? @"&" : @"", query];
}

- (void)addingQuery:(NSURLQueryItem *)item {
    if (!item) {
        NSAssert(NO, @"*** -[WSURLComponents addingQuery:]: item cannot be nil");
        return;
    }
    self.URLComponents.queryItems = [self.URLComponents.queryItems ? : @[] arrayByAddingObject:item];
}

- (void)addingQueryItems:(NSArray <NSURLQueryItem *> *)items {
    if (!items) {
        NSAssert(NO, @"*** -[WSURLComponents addingQueryItems:]: items cannot be nil");
        return;
    }
    self.URLComponents.queryItems = [self.URLComponents.queryItems ? : @[] arrayByAddingObjectsFromArray:items];
}

- (void)removeAllHeaders {
    self.URLHeadComponents.queryItems = @[];
}

- (void)removeHeaderForName:(NSString *)name {
    self.URLHeadComponents.queryItems = XYArrayRemoveWithName(self.URLHeadComponents.queryItems, name);
}

- (void)removeAllQuery {
    self.URLComponents.queryItems = @[];
}
- (void)removeQueryForName:(NSString *)name {
    self.URLComponents.queryItems = XYArrayRemoveWithName(self.URLComponents.queryItems, name);
}

#pragma mark Override

- (NSString *)description {
    NSMutableString *description = NSMutableString.new;
    [description appendFormat:@"<%@ %p> {\n", NSStringFromClass(self.class), self];
    [description appendFormat:@"\tscheme = %@\n", self.URLComponents.scheme];
    [description appendFormat:@"\tuser = %@\n", self.URLComponents.user];
    [description appendFormat:@"\tpassword = %@\n", self.URLComponents.password];
    [description appendFormat:@"\thost = %@\n", self.URLComponents.host];
    [description appendFormat:@"\tport = %@\n", self.URLComponents.port];
    [description appendFormat:@"\tpath = %@\n", self.URLComponents.path];
    [description appendFormat:@"\tfragment = %@\n", self.URLComponents.fragment];
    [description appendFormat:@"\tquery = %@\n", self.URLComponents.queryItems];
    [description appendFormat:@"\thead = %@", self.URLHeadComponents.queryItems];
    [description appendString:@"}"];
    return description.copy;
}

- (NSString *)debugDescription {
    NSMutableString *description = NSMutableString.new;
    [description appendFormat:@"<%@ %p> {\n", NSStringFromClass(self.class), self];
    [description appendFormat:@"\tscheme = %@\n", self.URLComponents.scheme];
    [description appendFormat:@"\tuser = %@\n", self.URLComponents.user];
    [description appendFormat:@"\tencode.user = %@\n", self.URLComponents.percentEncodedUser];
    [description appendFormat:@"\tpassword = %@\n", self.URLComponents.password];
    [description appendFormat:@"\tencode.password = %@\n", self.URLComponents.percentEncodedPassword];
    [description appendFormat:@"\thost = %@\n", self.URLComponents.host];
    [description appendFormat:@"\tencode.host = %@\n", self.URLComponents.percentEncodedHost];
    [description appendFormat:@"\tport = %@\n", self.URLComponents.port];
    [description appendFormat:@"\tpath = %@\n", self.URLComponents.path];
    [description appendFormat:@"\tencode.path = %@\n", self.URLComponents.percentEncodedPath];
    [description appendFormat:@"\tquery = %@\n", self.URLComponents.query];
    [description appendFormat:@"\tencode.query = %@\n", self.URLComponents.percentEncodedQuery];
    [description appendFormat:@"\tfragment = %@\n", self.URLComponents.fragment];
    [description appendFormat:@"\tencode.fragment = %@\n", self.URLComponents.percentEncodedFragment];
    [description appendFormat:@"\tquery = %@\n", self.URLComponents.queryItems];
    [description appendFormat:@"\thead = %@", self.URLHeadComponents.queryItems];
    [description appendString:@"}"];
    return description.copy;
}

#pragma mark Getter

- (NSURLComponents *)URLComponents {
    if (!_URLComponents) {
        _URLComponents = [NSURLComponents new];
    }
    return _URLComponents;
}

- (NSURLComponents *)URLHeadComponents {
    if (!_URLHeadComponents) {
        _URLHeadComponents = [NSURLComponents new];
    }
    return _URLHeadComponents;
}

#pragma NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    WSURLComponents *URLComponents = [[self.class allocWithZone:zone] init];
    URLComponents.method = self.method;
    URLComponents.URLComponents = [self.URLComponents copyWithZone:zone];
    URLComponents.URLHeadComponents = [self.URLHeadComponents copyWithZone:zone];
    URLComponents.URLComponents.password = self.URLComponents.password;
    return URLComponents;
}

#pragma NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeInteger:self.method forKey:NSStringFromSelector(@selector(method))];
    [aCoder encodeObject:self.URLComponents forKey:NSStringFromSelector(@selector(URLComponents))];
    [aCoder encodeObject:self.URLHeadComponents forKey:NSStringFromSelector(@selector(URLHeadComponents))];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    if (self = [super init]) {
        _method = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(method))];
        _URLComponents = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(URLComponents))];
        _URLHeadComponents = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(URLHeadComponents))];
    }
    return self;
}

@end
