//
//  YUIDataSourceObject.m
//  YUIAll
//
//  Created by YUI on 2021/7/15.
//

#import "YUIDataSourceObject.h"

@interface YUIDataSourceObject ()

@end

@implementation YUIDataSourceObject

#pragma mark - <UITableViewDataSource>

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return nil;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

#pragma mark - <UICollectionViewDataSource>

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 0;
}

@end
