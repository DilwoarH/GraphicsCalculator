//
//  CalculatorMainViewController.m
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorMainViewController.h"

@interface CalculatorMainViewController ()

@end

@implementation CalculatorMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(CalculatorFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
