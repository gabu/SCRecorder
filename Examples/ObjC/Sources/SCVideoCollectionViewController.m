//
//  SCVideoCollectionViewController.m
//  SCRecorderExamples
//
//  Created by Shoya Tsukada on 2016/01/04.
//
//

#import <Photos/Photos.h>
#import "SCVideoCollectionViewController.h"
#import "SCFilterImageViewController.h"

@interface SCVideoCollectionViewController ()

@property PHFetchResult *fetchResult;
@property PHCachingImageManager *imageManager;
@property PHAsset *selectedAsset;

@end

@implementation SCVideoCollectionViewController

static NSString * const reuseIdentifier = @"VideoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    PHFetchOptions *options = PHFetchOptions.new;
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options];
    self.imageManager = PHCachingImageManager.new;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PresentSCFilterImageViewController"]) {
        NSIndexPath *indexPath = self.collectionView.indexPathsForSelectedItems.firstObject;
        SCFilterImageViewController *vc = segue.destinationViewController;
        vc.videoAsset = self.fetchResult[indexPath.row];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    PHAsset *asset = self.fetchResult[indexPath.row];
    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(180, 180) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        ((UIImageView *)[cell viewWithTag:1]).image = result;
    }];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat length = self.view.bounds.size.width / 4.0f;
    return CGSizeMake(length, length);
}

@end
