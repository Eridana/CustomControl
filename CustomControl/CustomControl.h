//
//  CustomControl.h
//  CustomControl
//
//  Created by Женя Михайлова on 07.06.16.
//  Copyright © 2016 mikhailova. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@protocol CustomControlDelegate <NSObject>

- (void)didSelectItem:(NSString *)item atIndex:(NSUInteger)index;

@end

@interface CustomControl : UIView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) IBOutlet id<CustomControlDelegate> delegate;

- (void)setup;

@property (nonatomic) IBInspectable NSInteger selectedIndex;
@property (nonatomic) IBInspectable CGFloat elementHeight;
@property (nonatomic) IBInspectable CGFloat elementWidth;
@property (nonatomic) IBInspectable CGFloat selectedElementWidth;
@property (nonatomic) IBInspectable BOOL fixedInterval;

@property (nonatomic, strong) IBInspectable UIColor *elementBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedElementBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedTextColor;

- (void)addElementWithTitle:(NSString *)title atIndex:(NSUInteger)index;
- (void)removeElementAtIndex:(NSUInteger)index;
- (void)setSelectedIndex:(NSInteger)selectedIndex;

@end
