//
//  SearchResultsViewController.m
//  Events
//
//  Created by Ahlawat, Bittu on 7/1/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "SearchResultsViewController.h"

#import "EbayItem.h"
#import "MBProgressHUD.h"
#import "RPPEvent.h"
#import "RPPGetEventItemsCall.h"
#import "SearchResultsCell.h"



@interface SearchResultsViewController () <RPPGetEventItemsCallDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) RPPGetEventItemsCall *getEventsItemCall;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.event.title;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.items = [NSMutableArray new];
    self.getEventsItemCall = [[RPPGetEventItemsCall alloc] initWithDelgate:self event:self.event];
    [self.getEventsItemCall sendRequest];
    
}

#pragma mark - RPPGetEventItemsCallDelegate
- (void)itemsFound:(NSArray *)items
{
    [self.items addObjectsFromArray:items];
    [self.collectionView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SearchResultsCell reuseIdentifier] forIndexPath:indexPath];
    EbayItem *item = [self.items objectAtIndex:indexPath.item];
    [cell applyContentsFromItem:item];
    if([self shouldLoadNextPageAtIndexPath:indexPath])
        [self fetchNextPage];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    Uncomment below to open the ebay item in mobile safari
    
//    EbayItem *item = [self.items objectAtIndex:indexPath.item];
//    NSURL *itemURL = [NSURL URLWithString:item.itemURL];
//    [[UIApplication sharedApplication] openURL:itemURL];
}



#pragma mark - Helper
- (BOOL)shouldLoadNextPageAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.item == ([self.items count] - 10))
        return YES;
    
    return NO;
}

- (void)fetchNextPage
{
    [self.getEventsItemCall fetchNextPage];
}


@end
