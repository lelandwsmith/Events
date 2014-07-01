//
//  RPPEventItemsResponse.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "RPPEventItemsResponse.h"
#import "EbayItem.h"


#define kSearchRecordKey            @"searchRecord"
#define kItemIdKey                  @"itemId"
#define kTitleKey                   @"title"
#define kViewItemURLKey             @"viewItemURL"
#define kListingInfoKey             @"listingInfo"
#define kBuyItNowPriceKey           @"buyItNowPrice"
#define kValueKey                   @"value"
#define kCurrencyIdKey              @"currencyId"
#define kItemImageInfoKey           @"itemImageInfo"
#define kImageURLKey                @"imageURL"
#define kItemKey                    @"item"

@implementation RPPEventItemsResponse

- (NSArray *)itemsFromJsonData:(NSData *)responseData
{
    id obj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
	if ([obj isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"%@",[obj description]);
        NSArray *items = [self parseItemsFromDictionary:obj];
        return items;
    }
    return nil;
}

- (NSArray *)parseItemsFromDictionary:(NSDictionary *)dictionary
{
    NSArray *searchRecordsArray = [dictionary objectForKey:kSearchRecordKey];
    NSMutableArray *results = [NSMutableArray new];
    
    for(NSDictionary *searchRecord in searchRecordsArray)
    {
        NSDictionary *itemInfo = [searchRecord objectForKey:kItemKey];
        EbayItem *item = [[EbayItem alloc] init];
        item.title = itemInfo[kTitleKey];
        item.itemId = itemInfo[kItemIdKey];
        item.itemURL = itemInfo[kViewItemURLKey];
        item.price = [self priceFromItemInfo:itemInfo];
        item.imageURL = [self imageURLFromItemInfo:itemInfo];
        [results addObject:item];
    }
    return results;
}

- (NSString *)priceFromItemInfo:(NSDictionary *)itemInfo
{
    if(itemInfo == nil || [itemInfo isEqual:[NSNull null]])
        return nil;
    
    NSDictionary *listingInfo = itemInfo[kListingInfoKey];
    NSDictionary *buyItNowInfo = listingInfo[kBuyItNowPriceKey];
    NSString *currencyId = buyItNowInfo[kCurrencyIdKey];
    CGFloat price = [[buyItNowInfo objectForKey:kValueKey] floatValue];

    NSString *result = [NSString stringWithFormat:@"%@%.2f",[self symbolForCurrencyId:currencyId],price];
    return result;
}

- (NSString *)symbolForCurrencyId:(NSString *)currentId
{
    if([[currentId lowercaseString] isEqualToString:@"usd"])
        return @"$";
    
    return currentId;
}

- (NSString *)imageURLFromItemInfo:(NSDictionary *)itemInfo
{
    if(itemInfo == nil || [itemInfo isEqual:[NSNull null]])
        return nil;
    
    NSArray *imageInfoArray = [itemInfo objectForKey:kItemImageInfoKey];
    
    for(NSDictionary *imageInfo in imageInfoArray)
    {
        NSString *result = [imageInfo objectForKey:kImageURLKey];
        if([result length])
            return result;
    }
    
    return nil;
}

@end
