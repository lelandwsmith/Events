//
//  RPPEventsResponse.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPEventsResponse.h"
#import "RPPEvent.h"

#define kEventsKey              @"events"
#define kRppEventIdKey          @"id"
#define kNameKey                @"name"
#define kValueKey               @"value"
#define kPropertiesKey          @"properties"
#define kTypeAGraphic           @"MobileAppHero"
#define kTypeBGraphic           @"MobileAppBanner"
#define kMobileEventTitle       @"MobileEventTitle"
#define kDisplayName            @"DisplayName"
#define kStartDateKey           @"startDate"
#define kEndDateKey             @"endDate"


@implementation RPPEventsResponse

- (NSArray *)eventsFromJsonData:(NSData *)responseData
{
    id obj = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
	if ([obj isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"%@",[obj description]);
        NSArray *events = [self parseEventsFromDictionary:obj];
        return events;
    }
    return nil;
}

- (NSArray *)parseEventsFromDictionary:(NSDictionary *)dictionary
{
    NSArray *eventsArray = [dictionary objectForKey:kEventsKey];
    NSMutableArray *results = [NSMutableArray new];
    
    for(NSDictionary *eventInfo in eventsArray)
    {
        RPPEvent *event = [[RPPEvent alloc] init];
        event.eventId = [eventInfo objectForKey:kRppEventIdKey];
        event.title = [self titleFromEventInfo:eventInfo];
        event.imageURL = [self eventImageFromEventInfo:eventInfo];
        event.startDate = [NSDate dateWithTimeIntervalSince1970:[[eventInfo objectForKey:kStartDateKey] floatValue]/1000];
        event.endDate = [NSDate dateWithTimeIntervalSince1970:[[eventInfo objectForKey:kEndDateKey] floatValue]/1000];
        if([event.imageURL length])
            [results addObject:event];
    }
    return results;
}

- (NSString *)eventImageFromEventInfo:(NSDictionary *)eventInfo
{
    NSArray *eventProperties = [eventInfo objectForKey:kPropertiesKey];
    for(NSDictionary *eventProperty in eventProperties)
    {
        if([[eventProperty objectForKey:kNameKey] isEqualToString:kTypeBGraphic])
        {
            NSString *imageURL = [eventProperty objectForKey:kValueKey];
            return imageURL;
        }
    }
    return nil;
}

- (NSString *)titleFromEventInfo:(NSDictionary *)eventInfo
{
    NSString *result = nil;
    NSArray *eventProperties = [eventInfo objectForKey:kPropertiesKey];
    for(NSDictionary *eventProperty in eventProperties)
    {
        if([[eventProperty objectForKey:kNameKey] isEqualToString:kMobileEventTitle])
            result = [eventProperty objectForKey:kValueKey];
        
        if([[eventProperty objectForKey:kNameKey] isEqualToString:kDisplayName])
        {
            NSString *value = [eventProperty objectForKey:kValueKey];
            if([value length])
                result = value;
        }
    }
    return result;
}

@end
