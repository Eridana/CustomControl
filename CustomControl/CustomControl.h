//
//  CustomControl.h
//  CustomControl
//
//  Created by Женя Михайлова on 07.06.16.
//  Copyright © 2016 mikhailova. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface CustomControl : UIControl

@property (nonatomic, strong) NSArray *titles;

- (void)setup;

@property (nonatomic) IBInspectable NSInteger selectedIndex;
@property (nonatomic) IBInspectable CGFloat elementHeight;
@property (nonatomic) IBInspectable CGFloat elementWidth;
@property (nonatomic) IBInspectable CGFloat selectedElementWidth;
@property (nonatomic) IBInspectable BOOL fixedInterval;
@property (nonatomic) IBInspectable BOOL showSelectedItemBeforeSelection;

@property (nonatomic, strong) IBInspectable UIColor *elementBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedElementBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable UIColor *selectedTextColor;

- (void)addElementWithTitle:(NSString *)title atIndex:(NSUInteger)index;
- (void)removeElementAtIndex:(NSUInteger)index;
- (void)setSelectedIndex:(NSInteger)selectedIndex;

@end
