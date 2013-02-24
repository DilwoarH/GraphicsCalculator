//
//  CalculatorMainViewController.m
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorMainViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorMainViewController ()
{

    NSManagedObjectContext *context;

}


@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, weak) NSMutableDictionary *calculationArray;


@end

@implementation CalculatorMainViewController

- (CalculatorBrain *)brain{
    
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

/***************************************************************************************
            DEGUBBING
 ***************************************************************************************/


- (void) debugging
{
    NSLog(@"fnumber %g", firstNumber);
    NSLog(@"sNumber %g", secondNumber);
    NSLog(@"input %@", input);
    //NSLog(@"result %g", result);
}



/***************************************************************************************
            INITIALISATION
 ***************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    equalsButton = NO;
    input = [[NSMutableString alloc] init];
    firstNumber = 0;
    operation = nil;
    currentTape = [[NSMutableString alloc] init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***************************************************************************************
            SHAKE TO CLEARR
 ***************************************************************************************/

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        NSLog(@"Device Shaken!");
       
        [self showClearAlert];
 

    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


/***************************************************************************************
            SHAKE TO CLEAR ALERT
 ***************************************************************************************/

- (void)showClearAlert
{
	UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"CONFIRM"];
	[alert setMessage:@"Clear Calculations?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Yes"];
	[alert addButtonWithTitle:@"No"];
	[alert show];
	//[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self acButtonPressed];
	}
	else if (buttonIndex == 1)
	{
		// No
	}
}



/***************************************************************************************
            FLIPSIDE VIEW
 ***************************************************************************************/

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

/***************************************************************************************
            LAYOUT CHANGE ON ORIENTATION CHANGE 
 ***************************************************************************************/

-(void) willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                duration: (NSTimeInterval)duration
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
         [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [self layout_landscape];
        }
   else if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
       [self layout_portrait];
    }
}


/***************************************************************************************
            PROGRAMMATIC LAYOUT FOR PORTRAIT
 ***************************************************************************************/

- (void)layout_portrait{
    
    [self.display_back      setFrame:CGRectMake(0, 0, 321, 89)];
    [self.label_calculation setFrame:CGRectMake(10, 7, 301, 21)];
    [self.label_Answer      setFrame:CGRectMake(10, 36, 301, 53)];
    
    [self.button_tape       setFrame:CGRectMake(20, 97, 64, 44)];
    [self.button_2nd        setFrame:CGRectMake(92, 97, 64, 44)];
    [self.button_c          setFrame:CGRectMake(164, 97, 64, 44)];
    [self.button_ac         setFrame:CGRectMake(237, 97, 64, 44)];
    
    [self.button_sine       setFrame:CGRectMake(20, 144, 64, 44)];
    [self.button_cos        setFrame:CGRectMake(92, 144, 64, 44)];
    [self.button_tan        setFrame:CGRectMake(164, 144, 64, 44)];
    [self.button_plusminus  setFrame:CGRectMake(237, 144, 64, 44)];
    
    [self.button_log        setFrame:CGRectMake(20, 199, 64, 44)];
    [self.button_ln         setFrame:CGRectMake(92, 199, 64, 44)];
    [self.button_pi         setFrame:CGRectMake(164, 199, 64, 44)];
    [self.button_divide     setFrame:CGRectMake(237, 199, 64, 44)];
    
    [self.button_1x         setFrame:CGRectMake(20, 250, 64, 44)];
    [self.button_sqaure     setFrame:CGRectMake(92, 250, 64, 44)];
    [self.button_sq_root    setFrame:CGRectMake(164, 250, 64, 44)];
    [self.button_multiply   setFrame:CGRectMake(237, 250, 64, 44)];
    
    [self.button_seven      setFrame:CGRectMake(20, 301, 64, 44)];
    [self.button_eight      setFrame:CGRectMake(92, 301, 64, 44)];
    [self.button_nine       setFrame:CGRectMake(164, 301, 64, 44)];
    [self.button_substract  setFrame:CGRectMake(237, 301, 64, 44)];
    
    [self.button_four       setFrame:CGRectMake(20, 352, 64, 44)];
    [self.button_five       setFrame:CGRectMake(92, 352, 64, 44)];
    [self.button_six        setFrame:CGRectMake(164, 352, 64, 44)];
    [self.button_add        setFrame:CGRectMake(237, 352, 64, 44)];
    
    [self.button_one        setFrame:CGRectMake(20, 403, 64, 44)];
    [self.button_two        setFrame:CGRectMake(92, 403, 64, 44)];
    [self.button_three      setFrame:CGRectMake(164, 403, 64, 44)];
    
    [self.button_percent    setFrame:CGRectMake(20, 454, 64, 44)];
    [self.button_zero       setFrame:CGRectMake(92, 454, 64, 44)];
    [self.button_decimal    setFrame:CGRectMake(164, 454, 64, 44)];
    [self.button_equals     setFrame:CGRectMake(237, 403, 64, 95)];
    
    [self.button_history    setFrame:CGRectMake(282, 509, 18, 19)];
    [self.label_radians     setFrame:CGRectMake(20, 513, 63, 21)];
    [self.switch_Radians    setFrame:CGRectMake(91, 510, 79, 27)];
}


/***************************************************************************************
            PROGRAMMATIC LAYOUT FOR LANDSCAPE
 ***************************************************************************************/

- (void)layout_landscape{
    
    [self.display_back      setFrame:CGRectMake(0, 0, 568, 64)];
    [self.label_calculation setFrame:CGRectMake(20, 4, 538, 21)];
    [self.label_Answer      setFrame:CGRectMake(20, 25, 538, 39)];

    [self.button_tape       setFrame:CGRectMake(20, 82, 50, 40)];
    [self.button_c          setFrame:CGRectMake(20, 129, 50, 40)];
    [self.button_ac         setFrame:CGRectMake(20, 176, 50, 87)];
    
    [self.button_1x         setFrame:CGRectMake(91, 223, 50, 40)];
    [self.button_percent    setFrame:CGRectMake(91, 82, 50, 40)];
    [self.button_sine       setFrame:CGRectMake(91, 129, 50, 40)];
    [self.button_log        setFrame:CGRectMake(91, 176, 50, 40)];
    
    [self.button_2nd        setFrame:CGRectMake(149, 82, 50, 40)];
    [self.button_cos        setFrame:CGRectMake(149, 129, 50, 40)];
    [self.button_ln         setFrame:CGRectMake(149, 176, 50, 40)];
    [self.button_sqaure     setFrame:CGRectMake(149, 223, 50, 40)];
    
    [self.button_sq_root    setFrame:CGRectMake(207, 223, 50, 40)];
    [self.button_pi         setFrame:CGRectMake(207, 176, 50, 40)];
    [self.button_plusminus  setFrame:CGRectMake(207, 83, 50, 40)];
    [self.button_tan        setFrame:CGRectMake(207, 129, 50, 40)];
    
    [self.button_seven      setFrame:CGRectMake(278, 82, 64, 40)];
    [self.button_four       setFrame:CGRectMake(278, 133, 64, 40)];
    [self.button_one        setFrame:CGRectMake(278, 184, 64, 40)];
    [self.button_zero       setFrame:CGRectMake(278, 235, 64, 40)];
    
    [self.button_eight      setFrame:CGRectMake(350, 82, 64, 40)];
    [self.button_five       setFrame:CGRectMake(350, 133, 64, 40)];
    [self.button_two        setFrame:CGRectMake(350, 184, 64, 40)];
    [self.button_decimal    setFrame:CGRectMake(350, 235, 64, 40)];

    [self.button_nine       setFrame:CGRectMake(422, 82, 64, 40)];
    [self.button_six        setFrame:CGRectMake(422, 133, 64, 40)];
    [self.button_three      setFrame:CGRectMake(422, 184, 64, 40)];
    [self.button_equals     setFrame:CGRectMake(422, 235, 64, 40)];
    
    [self.button_divide     setFrame:CGRectMake(494, 82, 64, 40)];
    [self.button_multiply   setFrame:CGRectMake(494, 133, 64, 40)];
    [self.button_substract  setFrame:CGRectMake(494, 184, 64, 40)];
    [self.button_add        setFrame:CGRectMake(494, 235, 64, 40)];
    
    [self.button_history    setFrame:CGRectMake(260, 276, 18, 19)];
    [self.label_radians     setFrame:CGRectMake(20, 271, 63, 21)];
    [self.switch_Radians    setFrame:CGRectMake(91, 268, 79, 27)];
}

/***************************************************************************************
            AC BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)acButtonPressed {
    
    firstNumber = 0;
    secondNumber = 0;
    operation = nil;
    equalsButton = NO;
    decimal_current = NO;
    
    [input setString:@""];
    [self.label_calculation setText:@"0"];
    [self.label_Answer setText:@"0"];
}

/***************************************************************************************
            C BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)cButtonPressed:(id)sender {
    
    self.label_calculation.text = [self.brain cButton:self.label_calculation.text];
    
    
}

/***************************************************************************************
            NUMBER BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)numberPressed:(id)sender{
    
        UIButton *selected = (UIButton *)  sender;  //casts sender as UIButton

        [input appendString:selected.titleLabel.text]; //appends to input string
        [self.label_calculation setText:input]; //updates display

        if ([self.label_calculation.text length] == input.length)
        {
            firstNumber = [input doubleValue];  //if new calculation is pressed after pressing equals
        }
        
}

/***************************************************************************************
            DECIMAL BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)decimalButtonPressed:(id)sender {
    
    /* THINKING
     =============================================
     
     -> IF IT IS THE FIRST NUMBER ADD 0 BEFORE DECIMAL E.G. 0.3 NOT .3
     -> IF IT IS IN THE MIDDLE OF NUMBER JUST ADD THE DECIMAL AS NORMAL E.G. 1.2
     -> IF THE NUMBER IS NOT DECIMAL JUST AS ADD IT AS NORMAL E.G. 34
     -> IF THE DECIMAL IS ALREADY CONTAINED IN THE CURRENT NUMBER THEN DO ADD IT E.G. 2.2.3
     -> IF THE DECIMAL POINT IS REMOVED THEN THE BOOLEAN SHOULD BE RETURN TO FALSE
     
     ----------------------------------------------
     */
    
    UIButton *selected = (UIButton *)  sender;  //casts sender as UIButton

    double lastNum = [self.brain getLastNumber:self.label_calculation.text];
    NSLog(@"currentNumber (controller) = %g",lastNum);
    
    
    NSLog([self.brain zeroDecimalFix:self.label_calculation.text] ? @"0. Yes" : @"0. No");

    if (![self.brain zeroDecimalFix:self.label_calculation.text]){
    decimal_current = [self.brain containsDecimalPoint:lastNum];
    }
    else {decimal_current = YES;}
    
        
    NSLog(decimal_current ? @"decimal Yes" : @"decimal No");
    
    
    if (!decimal_current && (![self.brain getLastNumber:self.label_calculation.text]))
    {
        [input appendString:@"0."]; //adds 0.
        decimal_current = YES;
    }
    else if (!decimal_current)
    {
        [input appendString:selected.titleLabel.text];
    }
    
    [self.label_calculation setText:input]; //updates display
    


}

/***************************************************************************************
            OPERATION BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)operationPressed:(id)sender{
    
    [self debugging];
    
    double result;

    //if operation is not set first number to text
    if (operation == nil && equalsButton == NO){
        firstNumber = [self.label_calculation.text doubleValue];
        result = 0;
    }
    else if(operation != nil && equalsButton == NO){
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
        result = [self.brain doCalculation:operation :firstNumber :secondNumber];
        
        NSLog(@"result %g", result);

        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
        
        firstNumber = result;
      
    } else{
        result = 0;
        
    }
    
    //if equals buttons was pressed then do this
    if (equalsButton == YES) {
        [input setString:[NSString stringWithFormat:@"%g", firstNumber]];
        [self.label_calculation setText:input];
        equalsButton = NO;
    }
    
    
    
    UIButton *selected = (UIButton *)  sender;
    operation = [[NSString alloc] initWithString:selected.titleLabel.text];
    
    [input setString:[NSString stringWithFormat:@"%g", firstNumber]];
    [input appendString:@" "];
    [input appendString:selected.titleLabel.text];
    [input appendString:@" "];
    [self.label_calculation setText:input];
    
    
    [self debugging];
    NSLog(@"result %g", result);
    
}

/***************************************************************************************
            EQUALS BUTTON PRESSED
 ***************************************************************************************/


- (IBAction)equalsPressed:(id)sender {

        double result;
    
    
    //if operation is not set first number to text
    secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    
    

    if (equalsButton == YES) {
        [input setString:[NSString stringWithFormat:@"%g", firstNumber]];
        [input appendString:@" "];
        [input appendString:operation];
        [input appendString:@" "];
        [input appendString:[NSString stringWithFormat:@"%g", secondNumber]];
        [self.label_calculation setText:input];
        equalsButton = NO;
    }
    
    
        result = [self.brain doCalculation:operation :firstNumber :secondNumber];
 
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
      //  self.label_calculation.text = @"";
        
       // firstNumber = 0;
       // secondNumber = 0;
       // operation = nil;
        
        [input setString:@""];
        firstNumber = result;
        equalsButton = YES;
    
    
        
        [self debugging];
        NSLog(@"result %g", result);
    
    [currentTape setString:self.label_calculation.text];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
   
    NSLog(currentTape);

    
    [tape_view arrayByAddingObject:[NSString stringWithString:currentTape]];
 
    
    
     NSLog(@"%@", tape_view);
    
    
    
}


@end
