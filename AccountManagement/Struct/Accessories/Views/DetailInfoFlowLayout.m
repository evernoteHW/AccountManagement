//
//  DetailInfoFlowLayout.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/11.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "DetailInfoFlowLayout.h"


@interface DetailInfoFlowLayout ()

@property (nonatomic , strong) NSMutableArray *allItemAttributes;

@end

@implementation DetailInfoFlowLayout


- (NSMutableArray *)allItemAttributes {
    if (!_allItemAttributes) {
        _allItemAttributes = [NSMutableArray array];
    }
    return _allItemAttributes;
}

- (void)setCellWidth:(CGFloat)cellWidth
{
    _cellWidth = cellWidth;
    [self invalidateLayout];
}
- (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
    [self invalidateLayout];
}
- (void)setVerSpacing:(CGFloat)verSpacing
{
    _verSpacing = verSpacing;
    [self invalidateLayout];
}
- (void)setHorSpacing:(CGFloat)horSpacing
{
    _horSpacing = horSpacing;
    [self invalidateLayout];
}

- (void)invalidateLayout
{
    [super invalidateLayout];
}

- (void)prepareLayout
{
    [super prepareLayout];
    // Get the number of cells and the bounds size
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    [self.allItemAttributes removeAllObjects];
    
    //Header
    UICollectionViewLayoutAttributes *headerAttr  = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    headerAttr.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.cellHeaderHeight);
    [self.allItemAttributes addObject:headerAttr];
    
    
    //Cell
    for (NSUInteger i=0; i<cellCount; ++i)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self _layoutForAttributesForCellAtIndexPath:indexPath];
        [self.allItemAttributes addObject:attr];
        
    }
    
    //Footer

}
- (CGSize)collectionViewContentSize
{
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    // We should return the content size. Lets do some math:
    
    return CGSizeMake(self.collectionView.frame.size.width, 5 + (cellCount / 3 + 1) * (self.horSpacing +  self.cellHeight ) + 5 + self.cellHeaderHeight);
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.allItemAttributes;
}

- (UICollectionViewLayoutAttributes *)_layoutForAttributesForCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGRect frame = CGRectZero;
    frame.origin.x = self.verSpacing + (self.verSpacing + self.cellWidth  ) * ( indexPath.row % 3);
    //* (self.itemSize.width + self.horSpacing);
    frame.origin.y = self.cellHeaderHeight + self.horSpacing + (self.horSpacing + self.cellHeight ) * (indexPath.row / 3);
    frame.size = CGSizeMake(self.cellWidth, self.cellHeight);
    
    attr.frame = frame;
    
    return attr;
}


@end
