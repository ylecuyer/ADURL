//
//  ADURL.h
//  ADURL
//
//  Created by Jason Denizac on 10/9/13.
//  Copyright (c) 2013 AgileMD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ADURL : NSObject
/**
 * The full URL that was originally parsed. Both the protocol and host are
 * lowercased.
 * Example: 'http://user:pass@host.com:8080/p/a/t/h?query=string#hash'
 */
@property (nonatomic, strong) NSString * href;

/**
 * The request protocol, lowercased.
 * Example: 'http:'
 */
@property (nonatomic, strong) NSString * protocol;

/**
 * The authentication information portion of a URL.
 * Example: 'user:pass'
 */
@property (nonatomic, strong) NSString * auth;

/**
 * The full lowercased host portion of the URL, including port information.
 * Example: 'host.com:8080'
 */
@property (nonatomic, strong) NSString * host;

/**
 * Just the lowercased hostname portion of the host.
 * Example: 'host.com'
 */
@property (nonatomic, strong) NSString * hostname;

/**
 * The port number portion of the host.
 * Example: '8080'
 */
@property (nonatomic) NSInteger port;

/**
 * Concatenation of pathname and search.
 * Example: '/p/a/t/h?query=string'
 */
@property (nonatomic, strong) NSString * path;

/**
 * The path section of the URL, that comes after the host and before the query,
 * including the initial slash if present.
 * Example: '/p/a/t/h'
 */
@property (nonatomic, strong) NSString * pathname;

/**
 * The 'query string' portion of the URL, including the leading question mark.
 * Example: '?query=string'
 */
@property (nonatomic, strong) NSString * search;


/**
 * The querystring as a dictionary
 * Example: @{@"query": @"string"}
 */
@property (nonatomic, readonly, strong) NSMutableDictionary * query;

/**
 * The 'fragment' portion of the URL including the pound-sign.
 * Example: '#hash'
 */
@property (nonatomic, strong) NSString * hash;

+ (ADURL *) parse: (NSString *) urlStr;
+ (NSString *) encodeURIcomponent: (NSString *) str;
+ (NSString *) decodeURIcomponent: (NSString *) str;
@end