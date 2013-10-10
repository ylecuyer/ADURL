//
//  ADURL.m
//  ADURL
//
//  Created by Jason Denizac on 10/9/13.
//  Copyright (c) 2013 AgileMD. All rights reserved.
//

#import "ADURL.h"

@implementation ADURL
{
    BOOL changed;
}
@synthesize href=_href;
@synthesize protocol=_protocol;
@synthesize host=_host;
@synthesize auth=_auth;
@synthesize port=_port;
@synthesize pathname=_pathname;
@synthesize query=_query;

+ (ADURL *) parse:(NSString *)urlStr{
    ADURL *url = [ADURL new];
    url.href = urlStr;
    return url;
}

- (id) init{
    if (self = [super init]) {
        changed = NO;
    }
    return self;
}

- (NSMutableDictionary *) query {
    if (!_query) {
        _query = [NSMutableDictionary new];
    }
    return _query;
}

- (NSString *) href {
    NSMutableArray * href = [NSMutableArray new];
    if (_protocol) {
     [href addObject:_protocol];
    }
    [href addObject:@"//"];
    if (_auth) {
        [href addObject:_auth];
        [href addObject:@"@"];
    }
    [href addObject:self.host];
    [href addObject:self.path];
    if (_hash) {
        [href addObject:_hash];
    }
    [href addObject:self.search];
    
    return [href componentsJoinedByString: @""];
}

- (void) setHref:(NSString *)href{
    NSLog(@"not yet implemented");
}

- (void) setProtocol:(NSString *)protocol{
    _protocol = [protocol hasSuffix:@":"]
        ? protocol
        : [protocol stringByAppendingString:@":"];
}

- (NSString *) host{
    if (_port) {
        return [NSString stringWithFormat:@"%@:%d", _hostname, _port];
    } else {
        return _hostname;
    }
}

- (void) setHost:(NSString *) host {
    NSArray *parts = [host componentsSeparatedByString:@":"];
    _hostname = parts[0];
    if ([parts count] > 1) {
        _port = [parts[1] integerValue];
    } else {
        _port = 0;
    }
}

- (void) setSearch:(NSString *)search{
    if ([search hasPrefix:@"?"]){
        NSString *querystring = [search substringFromIndex:1];
        NSArray *pairs = [querystring componentsSeparatedByString:@"&"];
        [self.query removeAllObjects];
        [pairs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *pair = obj;
            NSRange range = [pair rangeOfString:@"="];
            NSString *key = [ADURL decodeURIcomponent:
                             [pair substringToIndex:range.location]];
            NSString *value = [ADURL decodeURIcomponent:
                               [pair substringFromIndex:range.location+range.length]];
            self.query[key] = value;
        }];
    }
}

- (NSString *) search {
    if (!_query.count) {
        return @"";
    }

    NSMutableArray *pairs = [NSMutableArray new];
    [_query enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [pairs addObject: [NSString stringWithFormat:@"%@=%@",
                           [ADURL encodeURIcomponent:key],
                           [ADURL encodeURIcomponent:obj]]];
    }];
    return [@"?" stringByAppendingString:
            [pairs componentsJoinedByString:@"&"]];
}
+ (NSString *) encodeURIcomponent: (NSString *) str{
    NSString *escapedString = (NSString *)CFBridgingRelease(
        CFURLCreateStringByAddingPercentEscapes(
                                                NULL,
                                                (__bridge CFStringRef) str,
                                                NULL,
                                                CFSTR(";:@&=+$,/?%#[]"),
                                                kCFStringEncodingUTF8
                                            )
                                        );
    return escapedString;
}
+ (NSString *) decodeURIcomponent: (NSString *) str{
    return [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end