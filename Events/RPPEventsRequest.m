//
//  RPPEventsRequest.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPEventsRequest.h"

@interface RPPEventsRequest ()
@property (nonatomic, strong) NSMutableURLRequest *request;
@end

@implementation RPPEventsRequest

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _request = [self urlRequest];
    }
    
    return self;
}

- (NSURLRequest *)activeEventsRequest
{
    return [self urlRequest];
}

- (NSMutableURLRequest *)urlRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self requestURL]
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:5.0f];
    [request setHTTPMethod:@"GET"];
    
    
    return request;
}

- (NSURL *)requestURL
{
    NSInteger siteID = 0; // US-Site
    
    NSTimeInterval intervalSince1970 = [[NSDate date] timeIntervalSince1970];
    NSInteger secondsFromGMT = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]];
    
    NSTimeInterval endsAfterTime = intervalSince1970 + secondsFromGMT;
    double endsAfterTimeInMilliseconds = endsAfterTime * 1000;
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.ebay.com/rps/events?channels=[11]&active=true&siteId=%d&endsAfter=%.0f&startsBefore=%.0f", siteID, endsAfterTimeInMilliseconds, endsAfterTimeInMilliseconds];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    return url;
}


@end
