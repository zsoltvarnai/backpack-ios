//
//  BadgeCollection.m
//  Skyscanner.TopicPage.iOS
//
//  Created by George Gillams on 4/3/19.
//

#import "BadgeCollection.h"
#import <Backpack/Badge.h>
#import <Backpack/Button.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>
#import <Backpack/TextView.h>
#import <Masonry/Masonry.h>

@interface BadgeCollection()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<BPKBadge *> *badges;

- (void) removeAllSubviews;
@end

@implementation BadgeCollection

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.badges = [[NSMutableArray<BPKBadge *> alloc] init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        self.badges = [[NSMutableArray<BPKBadge *> alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int rowEndPoint = 0;
    int selfWidth = self.frame.size.width;
    for (int i = 0 ; i < [self badges].count; i += 1) {
        BPKBadge *badge = [self badges][i];
        int thisBadgeWidth = badge.frame.size.width;
        [badge setNeedsLayout];
        [badge layoutIfNeeded];
        rowEndPoint += thisBadgeWidth + BPKSpacingSm;
        BOOL needsNewRow = rowEndPoint > selfWidth;
        if (needsNewRow) {
            rowEndPoint = thisBadgeWidth + BPKSpacingSm;
        }

        [badge setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [badge mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@22.0);
            if (i == 0) {
                make.top.equalTo(self.mas_top);
                make.leading.equalTo(self.mas_leading);
            }else{
                UIView *previousBadge = (UIView *)[self badges][i-1];
                if (needsNewRow && previousBadge) {
                    make.top.equalTo(previousBadge.mas_bottom).offset(BPKSpacingSm);
                    make.leading.equalTo(self.mas_leading);
                } else {
                    make.top.equalTo(previousBadge.mas_top);
                    make.leading.equalTo(previousBadge.mas_trailing).offset(BPKSpacingSm);
                }
            }
        }];
        if(i == [self badges].count - 1){
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo([[self badges] lastObject].mas_bottom);
            }];
        }
    }
}

- (void)removeAllSubviews {
    NSArray<UIView *> *subviews = [self subviews];
    for (int i = 0 ; i < subviews.count; i += 1) {
        [subviews[i] removeFromSuperview];
    }
    [self.badges removeAllObjects];
}

- (void)setNames:(NSArray<NSString *> *)names {
    [self removeAllSubviews];

    for (NSInteger i = 0; i < 10; i++) {
        BPKBadge *badge = [[BPKBadge alloc] initWithType:BPKBadgeTypeLight message:@"TEST_12"];
        [self.badges addObject:badge];
        [self addSubview:badge];
    }
}

@end
