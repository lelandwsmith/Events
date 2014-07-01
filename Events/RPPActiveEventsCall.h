//
//  RPPActiveEventsCall.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RPPActiveEventsCallDelegate;

@interface RPPActiveEventsCall : NSObject

- (instancetype)initWithDelgate:(id<RPPActiveEventsCallDelegate>)delegate;
- (void)sendRequest;

@end

@protocol RPPActiveEventsCallDelegate <NSObject>

- (void)eventsDownloaded:(NSArray *)events;

@end
