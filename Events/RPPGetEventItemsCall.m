//
//  RPPGetEventItemsCall.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPGetEventItemsCall.h"

#import "RPPEventItemsRequest.h"
#import "RPPEventItemsResponse.h"

@interface RPPGetEventItemsCall ()
@property (nonatomic, strong) RPPEventItemsRequest *eventItemsRequest;
@property (nonatomic, weak) id<RPPGetEventItemsCallDelegate> delegate;
@property (nonatomic, strong) RPPEvent *event;
@property (nonatomic, assign) NSUInteger pageNumber;
@property (nonatomic, assign) BOOL fetching;
@end

@implementation RPPGetEventItemsCall

- (instancetype)initWithDelgate:(id<RPPGetEventItemsCallDelegate>)delegate event:(RPPEvent *)event
{
    self = [self init];
    if(self)
    {
        _pageNumber = 0;
        _delegate = delegate;
        _event = event;
        [self createRequest];
    }
    return self;
}

- (void)createRequest
{
    self.eventItemsRequest = [[RPPEventItemsRequest alloc] initWithEvent:self.event pageNumber:self.pageNumber];
}

- (void)fetchNextPage
{
    self.pageNumber++;
    [self createRequest];
    [self sendRequest];
}

- (void)sendRequest
{
    if (self.fetching == NO)
    {
        NSString *body = [[NSString alloc] initWithData:[[self.eventItemsRequest request] HTTPBody] encoding:NSUTF8StringEncoding];
        NSLog(@"%@\n%@",[[self.eventItemsRequest request] description],body);
        
        self.fetching = YES;
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[self.eventItemsRequest request] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            RPPEventItemsResponse *eventItemsResponse = [[RPPEventItemsResponse alloc] init];
            NSArray *events =  [eventItemsResponse itemsFromJsonData:data];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate itemsFound:events];
                self.fetching = NO;
            }];
        }];
        
        [task resume];
    }
}


@end
