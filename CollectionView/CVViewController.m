//
//  CVViewController.m
//  CollectionView
//
//  Created by Ondřej Mirtes on 18.1.2013.
//  Copyright (c) 2013 Ondřej Mirtes. All rights reserved.
//

#import "CVViewController.h"

@interface CVViewController ()

@property (nonatomic, strong) NSMutableDictionary* cache;

@end

@implementation CVViewController

@synthesize cache = _cache;

- (NSMutableDictionary*) cache {
	if (_cache == nil) {
		_cache = [NSMutableDictionary dictionary];
	}
	
	return _cache;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 32;
}

- (NSInteger) fibonacciNumber:(NSInteger)num {
	if (num <= 1) {
		return 1;
	}
	return [self fibonacciNumber:(num - 1)] + [self fibonacciNumber:(num - 2)];
}

- (NSInteger) fibonacciNumberFromCache:(NSInteger)num {
	NSNumber* key = [NSNumber numberWithInt:num];
	if ([self.cache objectForKey:key] == nil) {
		NSNumber* result = [NSNumber numberWithInt:[self fibonacciNumber:num]];
		[self.cache setObject:result forKey:key];
	}
	return [[self.cache objectForKey:key] intValue];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FibonacciCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
	
	UILabel* label = (UILabel*) [cell viewWithTag:1];
	label.text = [NSString stringWithFormat:@"%d", [self fibonacciNumberFromCache:indexPath.row]];
	
    return cell;
}

@end
