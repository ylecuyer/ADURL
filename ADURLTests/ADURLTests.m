//
//  ADURLTests.m
//  ADURLTests
//
//  Created by Jason Denizac on 10/9/13.
//  Copyright (c) 2013 AgileMD. All rights reserved.
//

#import "ADURL.h"
#import "Kiwi.h"

SPEC_BEGIN(ADURLSpec)

describe(@"ADURL", ^{
    it(@"can build a url", ^{
        
        ADURL *url = [ADURL new];
        url.protocol = @"http";
        url.hostname = @"agilemd.com";
        url.path = @"/foo";
        url.query[@"bar"] = @"baz";
        
        [[url.href should] equal:@"http://agilemd.com/foo?bar=baz"];
    
    });

//    // TODO
//    it(@"parses a url into its components", ^{
//        ADURL *url = [ADURL parse:@"https://duckduckgo.com:443/?q=ice+cream"];
//        [[url.protocol should] equal:@"https:"];
//        [[url.host should] equal:@"duckduckgo.com:443"];
//        [[url.hostname should] equal:@"duckduckgo.com"];
//        [[theValue(url.port) should] equal:theValue(443)];
//        [[url.path should] equal:@"/?q=ice+cream"];
//        [[url.pathname should] equal:@"/"];
//        // spaces canonicalized to percent encoding
//        [[url.search should] equal:@"?q=ice%2Bcream"];
//        [[url.query[@"q"] should] equal:@"ice+cream"];
//        
//    });
    
    it(@"coerces : on protocol", ^{
        ADURL *url = [ADURL new];
        url.protocol = @"http";
        [[url.protocol should] equal:@"http:"];
        
        url.protocol = @"https:";
        [[url.protocol should] equal:@"https:"];
    });
    
    it(@"calculates host as hostname + port", ^{
        ADURL *url = [ADURL new];
        url.hostname = @"blarg.com";
        url.port = 2323;
        [[url.host should] equal:@"blarg.com:2323"];
        
        url.port = 0;
        [[url.host should] equal:@"blarg.com"];
    });
    
    it(@"setting host sets hostname + port", ^{
        ADURL *url = [ADURL new];
        url.host = @"securepizza.com:443";
        [[url.hostname should] equal:@"securepizza.com"];
        [[theValue(url.port) should] equal:theValue(443)];
        
        url.host = @"pizza.com";
        [[url.hostname should] equal:@"pizza.com"];
        [[theValue(url.port) should] equal:theValue(0)];
        
    });
    
    it(@"parses search into query", ^{
        ADURL *url = [ADURL new];
        url.search = @"?foo=bar&baz=qux";
        [[theValue([url.query count]) should] equal:theValue(2)];
        [[url.query[@"foo"] should] equal:@"bar"];
        [[url.query[@"baz"] should] equal:@"qux"];
        
        url.search = @"?state=CA";
        [[theValue([url.query count]) should] equal:theValue(1)];
        [[url.query[@"state"] should] equal:@"CA"];
        
    });
    it(@"unescapes search string when parsing query dict", ^{
        ADURL *url = [ADURL new];
        url.search = @"?what%3F=no%3Dwhey%3A%3A";
        [[url.query[@"what?"] should] equal:@"no=whey::"];
    });
    
    it(@"renders query into search", ^{
        ADURL *url = [ADURL new];
        url.query[@"foo"] = @"bar";
        [[url.search should] equal:@"?foo=bar"];
        
        url.query[@"baz"] = @"qux";
        [[url.search should] equal:@"?foo=bar&baz=qux"];
    });
    it(@"escapes querystring", ^{
        ADURL *url = [ADURL new];
        url.query[@"what?"]=@"no=whey::";
        [[url.search should] equal:@"?what%3F=no%3Dwhey%3A%3A"];
    });
});

// see http://xkr.us/articles/javascript/encode-compare/
describe(@"encodeURIcomponent", ^{
    it(@"escapes components of a URI including delimeters", ^{
        [[[ADURL encodeURIcomponent:@"~!@#$%^&*(){}[]=:/,;?+'\"\\"] should] equal:@"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C"];
        NSLog(@"%@", [ADURL encodeURIcomponent:@"anyone home?"]);
    });
});

describe(@"decodeURIcomponent", ^{
    it(@"escapes components of a URI including delimeters", ^{
        [[[ADURL decodeURIcomponent:@"~!%40%23%24%25%5E%26*()%7B%7D%5B%5D%3D%3A%2F%2C%3B%3F%2B'%22%5C"] should] equal:@"~!@#$%^&*(){}[]=:/,;?+'\"\\"];
    });
});
SPEC_END