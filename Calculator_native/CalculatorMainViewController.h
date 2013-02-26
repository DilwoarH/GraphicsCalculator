//
//  CalculatorMainViewController.h
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorFlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface CalculatorMainViewController : UIViewController <CalculatorFlipsideViewControllerDelegate>
{
    NSMutableString *input;
    NSString *operation;
    NSMutableString *currentTape;
    NSMutableArray *tape_view;
    double firstNumber;
    double secondNumber;
    BOOL equalsButton;
    BOOL decimal_current;
    BOOL specialPressed;
    BOOL secondPressed;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *label_calculation;
@property (weak, nonatomic) IBOutlet UILabel *label_Answer;
@property (weak, nonatomic) IBOutlet UILabel *display_back;

@property (weak, nonatomic) IBOutlet UIButton *button_tape;
@property (weak, nonatomic) IBOutlet UIButton *button_2nd;
@property (weak, nonatomic) IBOutlet UIButton *button_c;
@property (weak, nonatomic) IBOutlet UIButton *button_ac;

@property (weak, nonatomic) IBOutlet UIButton *button_sine;
@property (weak, nonatomic) IBOutlet UIButton *button_cos;
@property (weak, nonatomic) IBOutlet UIButton *button_tan;
@property (weak, nonatomic) IBOutlet UIButton *button_plusminus;

@property (weak, nonatomic) IBOutlet UIButton *button_log;
@property (weak, nonatomic) IBOutlet UIButton *button_ln;
@property (weak, nonatomic) IBOutlet UIButton *button_pi;

@property (weak, nonatomic) IBOutlet UIButton *button_1x;
@property (weak, nonatomic) IBOutlet UIButton *button_sqaure;
@property (weak, nonatomic) IBOutlet UIButton *button_sq_root;

@property (weak, nonatomic) IBOutlet UIButton *button_divide;
@property (weak, nonatomic) IBOutlet UIButton *button_multiply;
@property (weak, nonatomic) IBOutlet UIButton *button_substract;
@property (weak, nonatomic) IBOutlet UIButton *button_add;
@property (weak, nonatomic) IBOutlet UIButton *button_equals;

@property (weak, nonatomic) IBOutlet UIButton *button_decimal;
@property (weak, nonatomic) IBOutlet UIButton *button_percent;

@property (weak, nonatomic) IBOutlet UIButton *button_zero;
@property (weak, nonatomic) IBOutlet UIButton *button_one;
@property (weak, nonatomic) IBOutlet UIButton *button_two;
@property (weak, nonatomic) IBOutlet UIButton *button_three;
@property (weak, nonatomic) IBOutlet UIButton *button_four;
@property (weak, nonatomic) IBOutlet UIButton *button_five;
@property (weak, nonatomic) IBOutlet UIButton *button_six;
@property (weak, nonatomic) IBOutlet UIButton *button_seven;
@property (weak, nonatomic) IBOutlet UIButton *button_eight;
@property (weak, nonatomic) IBOutlet UIButton *button_nine;

//@property (weak, nonatomic) IBOutlet UIButton *button_history;
@property (weak, nonatomic) IBOutlet UILabel *label_radians;
@property (weak, nonatomic) IBOutlet UISwitch *switch_Radians;






@end
