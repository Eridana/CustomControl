//
//  ViewController.m
//  CustomControl
//
//  Created by Женя Михайлова on 07.06.16.
//  Copyright © 2016 mikhailova. All rights reserved.
//

#import "ViewController.h"
#import "CustomControl.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet CustomControl *control;
@property (weak, nonatomic) IBOutlet UITextField *indexTextField;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    self.control.titles = self.titles;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events

- (IBAction)deleteAtIndexTapped:(id)sender {
    NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
    [self.control removeElementAtIndex:index];
}

- (IBAction)insertAtIndexTapped:(id)sender {
    NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
    NSString *title = [NSString stringWithFormat:@"%ld", self.control.titles.count + 1];
    [self.control addElementWithTitle:title atIndex:index];
}

- (IBAction)selectItemAtIndexTapped:(id)sender {
    NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
    [self.control setSelectedIndex:index];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.indexTextField resignFirstResponder];
}

- (IBAction)fixedIntervalChanged:(id)sender {
    UISwitch *intervalSwitch = (UISwitch *)sender;
    self.control.fixedInterval = intervalSwitch.isOn;
}

- (IBAction)controlDidChange:(id)sender {
    CustomControl *control = (CustomControl *)sender;
    NSUInteger index = control.selectedIndex;
    self.indexTextField.text = [NSString stringWithFormat:@"%ld", index];
}

@end
