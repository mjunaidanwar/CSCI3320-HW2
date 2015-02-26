//
//  ViewController.m
//  Calculator
//
//  Created by Mohammed Junaid Anwar on 2/2/15.
//  Copyright (c) 2015 Calculator. All rights reserved.
//

#import "ViewController.h"
#import "Calculator-Brain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) Calculator_Brain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize display2;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(Calculator_Brain *)brain
{
    if(!_brain) _brain = [[Calculator_Brain alloc] init];
    return _brain;
}

- (IBAction)clearPressed:(UIButton *)sender
{
    self.display.text = @"0";
    self.display2.text = @"";
}

- (IBAction)backPressed:(id)sender              //Not perfect but should do the job
{
    NSString *string = [display text];
    double length = [string length];
    NSString *temp = [string substringToIndex:length-1];
    if([temp length] == 0) {
        temp = @"";
    }
    [display setText:temp];
    [display2 setText:temp];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}


- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    self.display2.text = [self.display2.text stringByAppendingString:digit];
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];

    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)decimalPressed:(UIButton *)sender
{
    NSRange range = [self.display.text rangeOfString:@"."]; //Solves the problem of multiple decimal points
    if (range.location ==NSNotFound)
    {
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.display2.text = [self.display2.text stringByAppendingString:@"."];
    } self.userIsInTheMiddleOfEnteringANumber = YES; //absence of else means that no function will take place if "." is already found.
}

- (IBAction)enterPressed
{
    self.display2.text = [self.display2.text stringByAppendingString:@" "];
    self.display.text = [self.display.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    [self.brain pushOperand:[self.display.text doubleValue]];
     self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(id)sender
{
    if(self.userIsInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    self.display2.text = [self.display2.text stringByAppendingString:operation];
    double result = [self.brain performOperation:operation];
    self.display.text= [NSString stringWithFormat:@"=%g", result];
}

@end
