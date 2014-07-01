//
//  RPPGetEventItemsCall.h
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RPPGetEventItemsCallDelegate;
@class RPPEvent;

@interface RPPGetEventItemsCall : NSObject

- (instancetype)initWithDelgate:(id<RPPGetEventItemsCallDelegate>)delegate event:(RPPEvent *)event;
- (void)sendRequest;
- (void)fetchNextPage;

@end

@protocol RPPGetEventItemsCallDelegate <NSObject>

- (void)itemsFound:(NSArray *)items;

@end
