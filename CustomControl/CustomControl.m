//
//  CustomControl.m
//  CustomControl
//
//  Created by Женя Михайлова on 07.06.16.
//  Copyright © 2016 mikhailova. All rights reserved.
//

#import "CustomControl.h"

const int DefaultSelectedElementWidth = 80;
const int DefaultElementsCount = 3;
const int DefaultSelectedIndex = -1;
const int DefaultElementHeight = 40;
const int DefaultElementWidth = 40;
const int DefaultInterval = 20;

@interface CustomControl ()

@property (nonatomic, strong) NSMutableArray *innerElements;

@end

@implementation CustomControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    if ([self.titles count] == 0) {
        self.titles = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    }
    
    if (self.selectedElementWidth == 0) {
        self.selectedElementWidth = DefaultSelectedElementWidth;
    }
    
    if (self.elementWidth == 0) {
        self.elementWidth = DefaultElementWidth;
    }
    
    if (self.elementHeight == 0) {
        self.elementHeight = DefaultElementHeight;
    }
    
    if (!self.textColor) {
        self.textColor = [UIColor blackColor];
    }
    
    if (!self.selectedTextColor) {
        self.selectedTextColor = [UIColor whiteColor];
    }
    
    if (!self.elementBackgroundColor) {
        self.elementBackgroundColor = [UIColor lightGrayColor];
    }
    
    if (!self.selectedElementBackgroundColor) {
        self.selectedElementBackgroundColor = [UIColor greenColor];
    }
    
    self.innerElements = [[NSMutableArray alloc] init];
    
    NSUInteger intervalsCount = self.titles.count - 1;
    
    float interval = DefaultInterval;

    if (!self.fixedInterval) {
        if (self.titles.count == 1) {
            interval = DefaultInterval;
        } else {
            interval = (self.frame.size.width - ((self.titles.count - 1) * self.elementWidth) - self.selectedElementWidth) / (float)intervalsCount;
        }
    }
    
    UIButton *lastDrownButton;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *elementButton;
        CGFloat originX = 0;
        
        if (lastDrownButton) {
            originX = lastDrownButton.frame.origin.x + lastDrownButton.frame.size.width + interval;
        } else {
            originX = i * (self.elementWidth + interval);
        }
        
        if (i == self.selectedIndex) {
            elementButton = [self buttonForPosition:originX index:i selected:YES];
        }
        else {
            elementButton = [self buttonForPosition:originX index:i selected:NO];
        }
    
        lastDrownButton = elementButton;
        
        [self.innerElements addObject:elementButton];
        [self addSubview:elementButton];
    }
    
    for (int i = 0; i < self.innerElements.count; i++) {
        
        UIButton *btn = self.innerElements[i];
        
        if (i + 1 != self.innerElements.count) {
            
            UIButton *nextBtn = self.innerElements[i + 1];
            float xPosition = btn.frame.origin.x + btn.frame.size.width;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(xPosition, self.elementHeight / 2 - 1, nextBtn.frame.origin.x - xPosition, 1)];
            line.backgroundColor = self.elementBackgroundColor;
            line.layer.zPosition = 0;
            [self addSubview:line];
        }
    }
}

- (UIButton *)buttonForPosition:(float)xPosition index:(int)index selected:(BOOL)selected
{
    float width = selected ? self.selectedElementWidth : self.elementWidth;
    UIColor *bgColor = selected ? self.selectedElementBackgroundColor : self.elementBackgroundColor;
    UIColor *textColor = selected ? self.selectedTextColor : self.textColor;
    
    UIButton *elementButton = [[UIButton alloc] initWithFrame:CGRectMake(xPosition, 0, width, self.elementHeight)];
    elementButton.selected = selected;
    elementButton.backgroundColor = bgColor;
    elementButton.titleLabel.textColor = textColor;
    elementButton.tag = index;
    elementButton.layer.zPosition = 1;
    [elementButton.layer setCornerRadius:self.elementWidth / 2];
    [elementButton addTarget:self action:@selector(didSelectElement:) forControlEvents:UIControlEventTouchUpInside];
    [elementButton setTitle:self.titles[index] forState:UIControlStateNormal&UIControlStateSelected];
    
    return elementButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setup];
}

#pragma mark - Setters

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self setup];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setup];
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor = selectedTextColor;
    [self setup];
}

- (void)setElementBackgroundColor:(UIColor *)elementBackgroundColor
{
    _elementBackgroundColor = elementBackgroundColor;
    [self setup];
}

- (void)setSelectedElementBackgroundColor:(UIColor *)selectedElementBackgroundColor
{
    _selectedElementBackgroundColor = selectedElementBackgroundColor;
    [self setup];
}

- (void)setElementWidth:(CGFloat)elementWidth
{
    _elementWidth = elementWidth;
    [self setup];
}

- (void)setSelectedElementWidth:(CGFloat)selectedElementWidth
{
    _selectedElementWidth = selectedElementWidth;
    [self setup];
}

- (void)setFixedInterval:(BOOL)fixedInterval
{
    _fixedInterval = fixedInterval;
    [self setup];
}

#pragma mark - Events

- (IBAction)didSelectElement:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.selectedIndex = btn.tag;
    
    [self setup];
    
    if ([self.delegate respondsToSelector:@selector(didSelectItem:atIndex:)]) {
        [self.delegate didSelectItem:[self.titles objectAtIndex:self.selectedIndex] atIndex:self.selectedIndex];
    }
}

#pragma mark - Add/remove/insert element(s)

- (void)addElementWithTitle:(NSString *)title atIndex:(NSUInteger)index
{
    if (index > self.titles.count - 1) {
        index = self.titles.count;
    }
    
    NSMutableArray *newTitles = [NSMutableArray arrayWithArray: self.titles];
    [newTitles insertObject:title atIndex:index];
    _titles = [newTitles copy];
    
    [self setup];
}

- (void)removeElementAtIndex:(NSUInteger)index
{
    if (index > self.titles.count - 1) {
        index = self.titles.count;
    }
    
    NSMutableArray *newTitles = [NSMutableArray arrayWithArray: self.titles];
    [newTitles removeObjectAtIndex:index];
    _titles = [newTitles copy];
    
    [self setup];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex > self.titles.count - 1) {
        _selectedIndex = self.titles.count - 1;
    }
    else {
        _selectedIndex = selectedIndex;
    }
    [self setup];
}

@end
