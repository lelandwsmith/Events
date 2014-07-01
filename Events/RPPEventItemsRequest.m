//
//  RPPEventItemsRequest.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPEventItemsRequest.h"

#import "RPPEvent.h"

@interface RPPEventItemsRequest ()
@property (nonatomic, strong) RPPEvent *event;
@property (nonatomic, assign) NSUInteger pageNumber;
@end

@implementation RPPEventItemsRequest

- (instancetype)initWithEvent:(RPPEvent *)event pageNumber:(NSUInteger)pageNumber
{
    self = [super init];
    if(self)
    {
        _event = event;
        _pageNumber = pageNumber;
    }
    return self;
}

- (NSURLRequest *)request
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self apiURL]
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                            timeoutInterval:5.0f];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *bodyData = [self bodyData];
    [request setHTTPBody:bodyData];
    
    NSString *contentLength = [NSString stringWithFormat:@"%u", [bodyData length]];
    [request addValue:contentLength forHTTPHeaderField:@"Content-Length"];
    
    return request;
}

- (NSURL *)apiURL
{
    return [NSURL URLWithString:@"http://www.ebay.com/rps/finditems"];
}

- (NSData *)bodyData
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:self.event.eventId forKey:@"eventId"];
    [dictionary setObject:[self scheduleDictionary] forKey:@"schedule"];
    [dictionary setObject:[self paginationDictionary] forKey:@"paginationInput"];
    [dictionary setObject:@"0" forKey:@"siteId"];
    [dictionary setObject:@11 forKey:@"channel"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
    return data;
}

- (NSDictionary *)scheduleDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary setObject:[self dateStringFrom:self.event.endDate] forKey:@"startsBefore"];
    [dictionary setObject:[self dateStringFrom:self.event.startDate] forKey:@"endsAfter"];
    return dictionary;
}

- (NSDictionary *)paginationDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[NSNumber numberWithInteger:self.pageNumber] forKey:@"pageNumber"];
    [dictionary setObject:[NSNumber numberWithInteger:50] forKey:@"entriesPerPage"];
    [dictionary setObject:[NSNumber numberWithInteger:0] forKey:@"minEntries"];
    return dictionary;
}

- (NSString *)dateStringFrom:(NSDate *)date
{
    NSDateFormatter *dateFormatter = nil;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return [dateFormatter stringFromDate:date];
}

@end
