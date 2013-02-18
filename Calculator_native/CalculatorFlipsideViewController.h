//
//  CalculatorFlipsideViewController.h
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorFlipsideViewController;

@protocol CalculatorFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(CalculatorFlipsideViewController *)controller;
@end

@interface CalculatorFlipsideViewController : UIViewController

@property (weak, nonatomic) id <CalculatorFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
