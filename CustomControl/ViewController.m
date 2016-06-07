//
//  ViewController.m
//  CustomControl
//
//  Created by Женя Михайлова on 07.06.16.
//  Copyright © 2016 mikhailova. All rights reserved.
//

#import "ViewController.h"
#import "CustomControl.h"

@interface ViewController () <CustomControlDelegate>
@property (nonatomic, weak) IBOutlet CustomControl *control;
@property (weak, nonatomic) IBOutlet UITextField *indexTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.control.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteAtIndexTapped:(id)sender {
    @try {
        NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
        [self.control removeElementAtIndex:index];
    }
    @catch (NSException *exception) {
        NSLog(@"error %@", [exception description]);
    }
}

- (IBAction)insertAtIndexTapped:(id)sender {
    @try {
        NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
        NSString *title = [NSString stringWithFormat:@"%ld", self.control.titles.count + 1];
        [self.control addElementWithTitle:title atIndex:index];
    }
    @catch (NSException *exception) {
        NSLog(@"error %@", [exception description]);
    }
}

- (IBAction)selectItemAtIndexTapped:(id)sender {
    @try {
        NSUInteger index = [[NSDecimalNumber decimalNumberWithString:self.indexTextField.text] unsignedIntegerValue];
        [self.control setSelectedIndex:index];
    }
    @catch (NSException *exception) {
        NSLog(@"error %@", [exception description]);
    }
}

- (IBAction)hideKeyboard:(id)sender {
    [self.indexTextField resignFirstResponder];
}

- (IBAction)fixedIntervalChanged:(id)sender {
    UISwitch *intervalSwitch = (UISwitch *)sender;
    self.control.fixedInterval = intervalSwitch.isOn;
}

#pragma mark - CustomControlDelegate

- (void)didSelectItem:(NSString *)item atIndex:(NSUInteger)index
{
    NSLog(@"did select item %@ at index %ld", item, index);
    self.indexTextField.text = [NSString stringWithFormat:@"%ld", index];
}

@end
