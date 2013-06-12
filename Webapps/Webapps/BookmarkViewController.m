//
//  BookmarkViewController.m
//  Webapps
//
//  Created by Thomas, Anna E on 05/06/2013.
//  Copyright (c) 2013 Team Awesome. All rights reserved.
//

#import "BookmarkViewController.h"
#import "BookmarkDataController.h"
#import "WebViewController.h"
#import "ViewDeckController.h"
#import "NavigationBarViewController.h"
#import "UIBookmark.h"
#import <QuartzCore/QuartzCore.h>
#import "BookmarkViewFlowLayout.h"

@implementation BookmarkViewController

- (IBAction)menuButtonClicked:(id)sender {
    [self.viewDeckController openLeftViewAnimated:YES];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.collectionView registerClass:[UIBookmark class] forCellWithReuseIdentifier:@"BookmarkCell"];
    [BookmarkDataController setViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)sidebarOpenClick:(id)sender {
    [self.viewDeckController openLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[BookmarkDataController instantiate] countOfBookmarks];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"BookmarkCell";
    
    UIBookmark *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    UIBookmark *bookmarkAtIndex = [[BookmarkDataController instantiate] bookmarkInListAtIndex:indexPath.row];
    
    cell.label.text = bookmarkAtIndex.label.text;
    
    [cell.layer setMasksToBounds:YES];
    [cell.layer setCornerRadius:15];
    [cell.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    cell.layer.shouldRasterize = YES;
    cell.layer.opaque = YES;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIBookmark *bookmark = [[BookmarkDataController instantiate] bookmarkInListAtIndex:indexPath.row];
    NSString *url = bookmark.url;
    [self performSegueWithIdentifier:@"webSegue" sender:url];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"webSegue"])
    {
        WebViewController *webViewController = segue.destinationViewController;
        webViewController.url = sender;
    }
}

@end
