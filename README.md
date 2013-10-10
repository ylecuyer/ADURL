# ADURL
a URL builder class based on node's url module

## usage
```objc
#import "ADURL.h"

ADURL *url = [ADURL new];
url.protocol = @"http";
url.hostname = @"agilemd.com";
url.path = @"/foo";
url.query[@"bar"] = @"baz";

url.href;
// => @"http://agilemd.com/foo?bar=baz"
```

Bonus: JavaScript-style encodeURIcomponent
and decodeURIcomponent class methods:
```objc
[ADURL encodeURIcomponent:@"anyone home?"];
// => @"anyone%20home%3F"
[ADURL decodeURIcomponent:@"anyone%20home%3F"];
// => @"anyone home?"
```

## installation
Using cocoapods, add to your podfile:
```
pod 'ADURL'
```

## api
```objc
@interface ADURL : NSObject
/**
 * The full URL that was originally parsed. Both the protocol and host are
 * lowercased.
 * Example: 'http://user:pass@host.com:8080/p/a/t/h?query=string#hash'
 */
@property (nonatomic) NSString * href;

/**
 * The request protocol, lowercased.
 * Example: 'http:'
 */
@property (nonatomic) NSString * protocol;

/**
 * The authentication information portion of a URL.
 * Example: 'user:pass'
 */
@property (nonatomic) NSString * auth;

/**
 * The full lowercased host portion of the URL, including port information.
 * Example: 'host.com:8080'
 */
@property (nonatomic) NSString * host;

/**
 * Just the lowercased hostname portion of the host.
 * Example: 'host.com'
 */
@property (nonatomic) NSString * hostname;

/**
 * The port number portion of the host.
 * Example: '8080'
 */
@property (nonatomic) NSInteger port;

/**
 * Concatenation of pathname and search.
 * Example: '/p/a/t/h?query=string'
 */
@property (nonatomic) NSString * path;

/**
 * The path section of the URL, that comes after the host and before the query,
 * including the initial slash if present.
 * Example: '/p/a/t/h'
 */
@property (nonatomic) NSString * pathname;

/**
 * The 'query string' portion of the URL, including the leading question mark.
 * Example: '?query=string'
 */
@property (nonatomic) NSString * search;


/**
 * The querystring as a dictionary
 * Example: @{@"query": @"string"}
 */
@property (nonatomic, readonly) NSMutableDictionary * query;

/**
 * The 'fragment' portion of the URL including the pound-sign.
 * Example: '#hash'
 */
@property (nonatomic) NSString * hash;

+ (ADURL *) parse: (NSString *) urlStr;
+ (NSString *) encodeURIcomponent: (NSString *) str;
+ (NSString *) decodeURIcomponent: (NSString *) str;
@end
```


## not yet implemented

- parser/setter for ADURL.href, [ADURL parse:]


## running the tests

Run in Xcode or `$ make test` in the project directory

## contributors

- jden <jason@denizac.org>


## license

MIT. (c) MMXIII AgileMD. See LICENSE.md
