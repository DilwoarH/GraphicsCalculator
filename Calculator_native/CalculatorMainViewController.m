//
//  CalculatorMainViewController.m
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorMainViewController.h"
#import "CalculatorBrain.h" //CALCULATOR BRAIN
#import "CalculatorAppDelegate.h" //APP DELEGATE FOR CORE DATA


@interface CalculatorMainViewController ()
{

    NSManagedObjectContext *context;  //initialise Object for CORE DATA

}


@property (nonatomic, strong) CalculatorBrain *brain; //CREATES INSTANCE OF BRAIN CLASS
@property (nonatomic, weak) NSMutableDictionary *calculationArray; //CREATES A CALCULATION ARRAY


@end

@implementation CalculatorMainViewController

//THIS METHOD CREATES THE INSTANCE

- (CalculatorBrain *)brain{
    
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

/***************************************************************************************
            DEGUBBING
 ***************************************************************************************/


- (void) debugging
{
    /*============
        
        SOME DEBUGGING HELP FOR TESTING
     
     =============*/
    
    
    
    NSLog(@"fnumber %g", firstNumber); //RETURN CURRENT FIRST NUMBER VARIABLE
    NSLog(@"sNumber %g", secondNumber); //RETURNS CURRENT SECOND NUMBER
    NSLog(@"input %@", input); //RETURNS WHAT IS IN THE INPUT FIELD (CALCULATION LABEL)
    //NSLog(@"result %g", result);
}



/***************************************************************************************
            INITIALISATION
 ***************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    equalsButton = NO; //INITIALISE EQUALSBUTTON TO OFF
    input = [[NSMutableString alloc] init]; //CREATES INSTANCE OF INPUT MUTABLE STRING
    firstNumber = 0; //SETS FIRST NUMBER TO ZERO
    operation = nil; //SET OPERATION TO NIL
    currentTape = [[NSMutableString alloc] init]; //CREATES INSTANCE OF CURRENT TYPE MUTABLE STRING
       
    
    //core data stuff
    CalculatorAppDelegate *appdelegate = [[UIApplication sharedApplication]delegate]; //CREATES THE DELEGATE FOR CORE DATA
    context = [appdelegate managedObjectContext]; //SETS CONTEXT TO CURRENT DELEGATE
    
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
        //CHECKS FOR MOTION ON DEVICE
        
        NSLog(@"Device Shaken!");
       
        //SHOWS ALERT
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
	UIAlertView *alert = [[UIAlertView alloc] init]; //CREATES INSTANCE FOR ALERT
	[alert setTitle:@"CONFIRM"]; //SETS ALERT TITLE
	[alert setMessage:@"Clear Calculations?"]; //SETS ALERT MESSAGE
	[alert setDelegate:self]; //SETS DELEGATE
	[alert addButtonWithTitle:@"Yes"]; //SETS FIRST BUTTON
	[alert addButtonWithTitle:@"No"]; //SETS SECOUND BUTTON
	[alert show]; //SHOWS ALERT
	//[alert release];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //THIS FUNCTION CATCHES RESPONSE FROM ALERT
    
	if (buttonIndex == 0)
	{
		[self acButtonPressed]; //CLEARS CALCULATIONS IF YES IS SELECTED
	}
	else if (buttonIndex == 1)
	{
		// No --- DO NOTHING
	}
}



/***************************************************************************************
            FLIPSIDE VIEW
 ***************************************************************************************/

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(CalculatorFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil]; //DISMISSES CURRENT VIEW
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    } //SEGUES TO FLIP VIEW
}

/***************************************************************************************
            LAYOUT CHANGE ON ORIENTATION CHANGE 
 ***************************************************************************************/

-(void) willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                duration: (NSTimeInterval)duration
{
    //ORIENTATION LISTENER
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
         [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        [self layout_landscape]; //IF VIEW IS LANDSCAPE CHANGE BUTTON LOCATION AND SIZE
        }
   else if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown)  {
       [self layout_portrait]; //IF PORTRAIT RETURN TO ORIGINAL STATE
    }
}


/***************************************************************************************
            PROGRAMMATIC LAYOUT FOR PORTRAIT
 ***************************************************************************************/

- (void)layout_portrait{
    
    //SETS OUT LAYOUT OF BUTTONS AND OBJECTS PROGRAMMATICALLY TOP - BUTTON
    
    [self.display_back      setFrame:CGRectMake(0, 0, 321, 89)];
    [self.label_calculation setFrame:CGRectMake(10, 7, 301, 21)];
    [self.label_Answer      setFrame:CGRectMake(10, 36, 301, 53)];
    
    [self.button_tape       setFrame:CGRectMake(20, 97, 64, 44)];
    [self.button_2nd        setFrame:CGRectMake(92, 97, 64, 44)];
    [self.button_c          setFrame:CGRectMake(164, 97, 64, 44)];
    [self.button_ac         setFrame:CGRectMake(237, 97, 64, 44)];
    
    [self.button_sine       setFrame:CGRectMake(20, 149, 64, 44)];
    [self.button_cos        setFrame:CGRectMake(92, 149, 64, 44)];
    [self.button_tan        setFrame:CGRectMake(164, 149, 64, 44)];
    [self.button_plusminus  setFrame:CGRectMake(237, 149, 64, 44)];
    
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
    
 //   [self.button_history    setFrame:CGRectMake(282, 509, 18, 19)];
    [self.label_radians     setFrame:CGRectMake(152, 509, 63, 21)];
    [self.switch_Radians    setFrame:CGRectMake(223, 506, 79, 27)];
}


/***************************************************************************************
            PROGRAMMATIC LAYOUT FOR LANDSCAPE
 ***************************************************************************************/

- (void)layout_landscape{
    
    //LAYOUT FOR LANDSCAPE
    
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
    
   // [self.button_history    setFrame:CGRectMake(260, 276, 18, 19)];
    [self.label_radians     setFrame:CGRectMake(100, 271, 63, 21)];
    [self.switch_Radians    setFrame:CGRectMake(171, 268, 79, 27)];
}

/***************************************************************************************
            AC BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)acButtonPressed {
    
    //CLEARS CALCULATIONS AND BOOLEANS
    
    firstNumber = 0;
    secondNumber = 0;
    operation = nil;
    equalsButton = NO;
    decimal_current = NO;
    specialPressed = NO;
    
    [input setString:@""];
    [self.label_calculation setText:@"0"];
    [self.label_Answer setText:@"0"];
    
    
    //CORE DATA
    
    [currentTape setString:@"ALL CLEAR"]; //SET CURRENT TAPE STRING 
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context]; //SELECTS TABLE
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context]; //SETS MANAGEMENT OBJECT
    
    [newCalculation setValue:currentTape forKey:@"calculation"]; //SETS VALUE TO COLUMB
    
    NSError *error; //ERROR CATCH
    [context save:&error]; //SAVE CONTEXT
}

/***************************************************************************************
            C BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)cButtonPressed:(id)sender {
    
    self.label_calculation.text = [self.brain cButton:self.label_calculation.text]; //CLEARS LAST ENTERED NUMBER OR OPERATION
    [input setString:self.label_calculation.text]; //SETS INPUT STRING TO CURRENT LABEL_CALCULATION
    
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
    
    specialPressed = NO; //RESETS SEPECIAL OPERATION BOOL
    
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

    //CHECKS IF THERE IS A 0 BEFORE DECIMAL
    if (![self.brain zeroDecimalFix:self.label_calculation.text]){
    decimal_current = [self.brain containsDecimalPoint:lastNum]; //CHECKS IF CURRENT NUMBER HAS DECIMAL
    }
    else {decimal_current = YES;}
    
        
    NSLog(decimal_current ? @"decimal Yes" : @"decimal No");
    
    //IF NO DECIMAL THEN IT APPENDS DECIMAL POINT ACCORDINGLY
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
    
    double result = 0.0; //INITIALISE RESULT

    
    //if operation is not set first number to text
    if (specialPressed == YES) //CHECK IF A SPECIAL OPERATION HAS BEEN TOGGLED IF YES THEN SET THE ANSWER TO FIRST NUMBER
                                            //THIS IS TO HELP WITH CONCATINATING CALCULATION
    {
        firstNumber = [self.label_Answer.text doubleValue]; //SETS FIRST NUMBER TO ANSWER
        specialPressed = NO; //TOGGLE OFF
    
    }
    else if (operation == nil && equalsButton == NO){ //IF NO OPERATION HAS BEEN SELECTED AND EQUALS HASNT BEEN PRESSED
        firstNumber = [self.label_calculation.text doubleValue]; //SET FIRST NUMBER TO NUMBER ON CURRENT DISPLAY
    }
    else if(operation != nil && equalsButton == NO){ //IF OPERATION HAS BEEN PRESSED
        secondNumber = [self.brain getLastNumber:self.label_calculation.text]; //SET SECOND NUMBER TO THE LAST NUMBER IN CALCULATION
        result = [self.brain doCalculation:operation :firstNumber :secondNumber]; //DO THE CALCULATION
        
        NSLog(@"result %g", result);

        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result]; //SET RESULT TO ANSWER
        
        firstNumber = result; //SET ANSWER TO FIRST NUMBER FOR CONCATINATION
      
    }
    
    //if equals buttons was pressed then do this
    if (equalsButton == YES) {
        [input setString:[NSString stringWithFormat:@"%g", firstNumber]]; //SET INPUT STRING TO FIRSTNUMBER
        [self.label_calculation setText:input]; //UPDATE LABEL
        equalsButton = NO; //TOGGLE OFF
    }
    
    UIButton *selected = (UIButton *)  sender; //SETS CALLING BUTTON TO SELECTED
    operation = [[NSString alloc] initWithString:selected.titleLabel.text]; //GETS THE OPERATION THAT WAS CLICKED
    
    [input setString:[NSString stringWithFormat:@"%g", firstNumber]]; //SETS FIRSTNUMBER TO DISPLAY
    [input appendString:@" "]; //ADDS SPACE (THIS WILL BE USED TO SEPERATE INTO ARRAY AND LOOKS NICER :)
    [input appendString:selected.titleLabel.text]; //ADDS OPERATION
    [input appendString:@" "]; //ANOTHER SPACE BEFORE SECOND NUMBER
    [self.label_calculation setText:input]; //UPDATES DISPLAY
    
    
    [self debugging];
    NSLog(@"result %g", result);
    
}

/***************************************************************************************
            EQUALS BUTTON PRESSED
 ***************************************************************************************/


- (IBAction)equalsPressed:(id)sender {

        double result;
    
    if (specialPressed == NO){                      //IF SPECIAL NUMBER IS PRESSED THEN DONT DO EQUALS AS IT CREATES PROBLEMS
    //if operation is not set first number to text
    secondNumber = [self.brain getLastNumber:self.label_calculation.text]; 

    if (equalsButton == YES) {
        [input setString:[NSString stringWithFormat:@"%g", firstNumber]]; //IF EQUAL HAS BEEN PRESSED THEN ADD CURRENT ANSWER AND
        [input appendString:@" "];                                          //KEEP DOING SAME OPERATION
        [input appendString:operation];
        [input appendString:@" "];
        [input appendString:[NSString stringWithFormat:@"%g", secondNumber]];
        [self.label_calculation setText:input];
        equalsButton = NO;
    }
    
        result = [self.brain doCalculation:operation :firstNumber :secondNumber]; //GET RESULTS
 
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result]; //UPDATE DISPLAY
        
        [input setString:@""];
        firstNumber = result; //SET FIRST NUMBER TO RESULT
        equalsButton = YES; //SET TOGGLE ON
    
        [self debugging];
        NSLog(@"result %g", result);
    
    ////CORE DATA
    
    [currentTape setString:self.label_calculation.text];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];

    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
    
    }
    
}

/***************************************************************************************
            RECIPROCAL
 ***************************************************************************************/

- (IBAction)oneOverXPressed:(id)sender {
    
    double result = 0.0;
    
    [self debugging];

    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
        else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
    result = [self.brain doOneOverX:secondNumber];
    
    firstNumber = result;
    secondNumber = result;
        
    self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        [self.label_Answer setText:@"Error. Value Undefined"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];

    specialPressed = YES;
    
    
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"1/%g", enteredNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
    
}

    


/***************************************************************************************
            SQUARE NUMBER
 ***************************************************************************************/

- (IBAction)squareNumber:(id)sender {
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        result = [self.brain doSquare:secondNumber];
        
        firstNumber = result;
        secondNumber = result;

        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
     specialPressed = YES;
    
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"%g²", enteredNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}

/***************************************************************************************
            SQUARE ROOT NUMBER
 ***************************************************************************************/


- (IBAction)squareRoot:(id)sender {
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        result = [self.brain doSquareRoot:secondNumber];
        
        firstNumber = result;
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"√%g", enteredNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}

/***************************************************************************************
        LOG NUMBER
 ***************************************************************************************/

- (IBAction)logButtonPressed:(id)sender {
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        result = [self.brain doLog:secondNumber];
        
        firstNumber = result;
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else if(secondNumber != 0){
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"㏒%g", enteredNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}

/***************************************************************************************
            LN NUMBER
 ***************************************************************************************/

- (IBAction)lnButtonPressed:(id)sender {
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        result = [self.brain doLn:secondNumber];
        
        firstNumber = result;
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"㏑%g", enteredNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}


/***************************************************************************************
            Pi BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)piButtonPressed:(id)sender {
    
    firstNumber = [self.brain getPI]; //RETURNS PI
    self.label_Answer.text = [NSString stringWithFormat:@"%1.8f", firstNumber];
    self.label_calculation.text = [NSString stringWithFormat:@"%1.8f", firstNumber];
    equalsButton = YES;
    specialPressed = YES;
    //NEEDS FIXING
    
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"π"]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%1.8f", M_PI]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}


/***************************************************************************************
            SIN or ARCSINE BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)sinButtonPressed:(id)sender {
    
    UIButton *selected = (UIButton *)  sender; //GETS SENDER
    NSString *title = [[NSString alloc] initWithString:selected.titleLabel.text]; //GETS SENDERS LABEL
    BOOL radians = self.switch_Radians.isOn ? YES : NO; //IF RADIAN SWITCH IS ON OR OFF SET BOOL ACCORDINGLY

    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
     double enteredNumber = secondNumber;
    
      if (secondNumber){ //IF NUMBER IS NOT ZERO DO THIS
          
    if ([title isEqualToString:@"sin"]) //IF IT EQUALS TO SINE THEN DO
    {
        result = [self.brain doSine:secondNumber:radians]; //SINE CALCULATION
        [currentTape setString:[NSString stringWithFormat:@"sin %g", enteredNumber]]; //UPDATE CURRENT TAPE STRING
    }
    else if ([title isEqualToString:@"sin⁻¹"]) //IF ARCSINE
    {
        result = [self.brain doArcSine:secondNumber:radians];
        [currentTape setString:[NSString stringWithFormat:@"sin⁻¹ %g", enteredNumber]];
    }
  
        firstNumber = result; //SET NUMBERS TO RESULTS
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result]; //SETS LABEL
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"]; //IF NO NUMBER IS SET BEFORE SET HELP DISPLAY
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    if (secondPressed == YES)
    {
        [self button2ndFunctionPressed:nil]; //IF ARC BUTTON IS TOGGLED DO THIS
    }
    
    
    ////CORE DATA
    
    
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
    
}

/***************************************************************************************
            COS or ARCCOS BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)cosButtonPressed:(id)sender {
    
    
    UIButton *selected = (UIButton *)  sender;
    NSString *title = [[NSString alloc] initWithString:selected.titleLabel.text];
    BOOL radians = self.switch_Radians.isOn ? YES : NO;
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        
        if ([title isEqualToString:@"cos"])
        {
            result = [self.brain doCos:secondNumber:radians];
            [currentTape setString:[NSString stringWithFormat:@"cos %g", enteredNumber]];
        }
        else if ([title isEqualToString:@"cos⁻¹"])
        {
            result = [self.brain doArcCos:secondNumber:radians];
            [currentTape setString:[NSString stringWithFormat:@"cos⁻¹ %g", enteredNumber]];
        }
        
        firstNumber = result;
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    if (secondPressed == YES)
    {
        [self button2ndFunctionPressed:nil];
    }
    
    
    
    ////CORE DATA
    
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
    
}

/***************************************************************************************
            TAN or ARCTAN BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)tanButtonPressed:(id)sender {
    
    UIButton *selected = (UIButton *)  sender;
    NSString *title = [[NSString alloc] initWithString:selected.titleLabel.text];
    BOOL radians = self.switch_Radians.isOn ? YES : NO;
    
    double result = 0.0;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    NSLog(@"second %g", secondNumber);
    
    double enteredNumber = secondNumber;
    
    if (secondNumber){
        
        if ([title isEqualToString:@"tan"])
        {
            result = [self.brain doTan:secondNumber:radians];
            [currentTape setString:[NSString stringWithFormat:@"tan %g", enteredNumber]];

        }
        else if ([title isEqualToString:@"tan⁻¹"])
        {
            result = [self.brain doArcTan:secondNumber:radians];
            [currentTape setString:[NSString stringWithFormat:@"tan⁻¹ %g", enteredNumber]];

            NSLog(@"tan-1");
        }
        
        firstNumber = result;
        secondNumber = result;
        
        self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
    [self.label_calculation setText:@""];
    [input setString:@""];
    
    specialPressed = YES;
    
    if (secondPressed == YES)
    {
        [self button2ndFunctionPressed:nil];
    }
    
    ////CORE DATA
    
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
}

/***************************************************************************************
            +/- BUTTON PRESSED   
 ***************************************************************************************/
- (IBAction)positiveNegativePressed:(id)sender {
    double result;
    
    [self debugging];
    
    if (specialPressed == YES || equalsButton == YES)
    {
        secondNumber = [self.label_Answer.text doubleValue];
        equalsButton = NO;
    }
    else {
        secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    }
    
    
    NSLog(@"second %g", secondNumber);
    
    
    if (secondNumber){
        
        NSString *newCal = [self.brain doPositiveNegativeOnLastNumber:self.label_calculation.text]; //CHANGES SIGN ON LAST NUMBER ADDED
        result = [self.brain doPositiveNegative:secondNumber]; //GETS RESULTS IN DOUBLE FORMAT
        
        //firstNumber = result;
        secondNumber = result;
        
        self.label_calculation.text = [NSString stringWithFormat:@"%@", newCal];
        
        
       // self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    }
    else {
        self.label_Answer.text = [NSString stringWithFormat:@"Enter Digit First"];
    }
    
   // [self.label_calculation setText:@""];
   // [input setString:@""];
    
  //  specialPressed = YES;
}

/***************************************************************************************
            2ND FUNC BUTTON PRESSED
 ***************************************************************************************/

- (IBAction)button2ndFunctionPressed:(id)sender {
    
    if (secondPressed == NO) {
        
    [self.button_sine setTitle:@"sin⁻¹" forState:UIControlStateNormal];  //TOOGLES FOR EFFECT
    [self.button_sine setHighlighted:YES];
    
    
    [self.button_cos setTitle:@"cos⁻¹" forState:UIControlStateNormal];
    [self.button_cos setHighlighted:YES];
    
    
    [self.button_tan setTitle:@"tan⁻¹" forState:UIControlStateNormal];
    [self.button_tan setHighlighted:YES];
    
  //  [self.button_2nd setHighlighted:YES];
        
        secondPressed = YES; //TOOGLE ON FOR CHECK WHEN BUTTON PRESSED
    
    }
    else{
    
    [self.button_sine setTitle:@"sin" forState:UIControlStateNormal]; //TOGGLE OFF
    [self.button_sine setHighlighted:NO];
    
    [self.button_cos setTitle:@"cos" forState:UIControlStateNormal];
    [self.button_cos setHighlighted:NO];
    
    [self.button_tan setTitle:@"tan" forState:UIControlStateNormal];
    [self.button_tan setHighlighted:NO];
    
 //   [self.button_2nd setHighlighted:NO];
        
        secondPressed = NO;
    
    }
   // self.button_sine.titleLabel.font = [UIFont systemFontOfSize:9];
    
}


/***************************************************************************************
        PERCENT BUTTON PRESSED
 ***************************************************************************************/


- (IBAction)percentButtonPressed {
    
    double result = 0.0;
    
    secondNumber = [self.brain getLastNumber:self.label_calculation.text];
    
    result = [self.brain doPercentage:operation :firstNumber :secondNumber];
    
    self.label_Answer.text = [NSString stringWithFormat:@"%.8g", result];
    
    double enteredNumber = firstNumber;
    
    [input setString:@""];
    firstNumber = result;

    
    [self debugging];
    NSLog(@"result %g", result);

    specialPressed = YES;
    
    ////CORE DATA
    
    [currentTape setString:[NSString stringWithFormat:@"%g %@ %g", enteredNumber, operation, secondNumber]];
    [currentTape appendString:@" = "];
    [currentTape appendString:[NSString stringWithFormat:@"%g", result]];
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSManagedObject *newCalculation = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newCalculation setValue:currentTape forKey:@"calculation"];
    
    NSError *error;
    [context save:&error];
    
}





@end
