//
//  ViewController.m
//  Events
//
//  Created by Ahlawat, Bittu on 6/30/14.
//  Copyright (c) 2014 eBay. All rights reserved.
//

#import "EventsViewController.h"

#import "EventsCollectionViewCell.h"
#import "MBProgressHUD.h"
#import "RPPActiveEventsCall.h"
#import "RPPEvent.h"
#import "SearchResultsViewController.h"

@interface EventsViewController () <RPPActiveEventsCallDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) RPPActiveEventsCall *activeEventsCall;
@property (nonatomic, strong) MBProgressHUD *progressHud;
@end

@implementation EventsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Events", nil);
	
    self.activeEventsCall = [[RPPActiveEventsCall alloc] initWithDelgate:self];
    [self.activeEventsCall sendRequest];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}


#pragma mark - RPPActiveEventsCallDelegate
- (void)eventsDownloaded:(NSArray *)events
{
    self.events = events;
    [self.collectionView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EventsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EventsCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    RPPEvent *event = [self.events objectAtIndex:indexPath.item];
    [cell applyContentsFromEvent:event];
    return cell;
}


#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SearchResultsPage"])
    {
        SearchResultsViewController *controller = [segue destinationViewController];
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        [controller setEvent:[self.events objectAtIndex:indexPath.item]];
    }
}

@end
