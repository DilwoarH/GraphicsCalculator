//
//  CalculatorBrain.m
//  Calculator_native
//
//  Created by Dilwoar Hussain on 20/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorBrain.h"

// Radians to degrees
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

// Degrees to radians
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@implementation CalculatorBrain


/***************************************************************************************
            DO CALCULATION FUNCTION
 ***************************************************************************************/

- (double) doCalculation:(NSString *)operation :(double)firstNumber :(double)secondNumber{
    
    /* THINKING
     =============================================
     
     -> GET OPERATION, FIRST NUMBER, SECOND NUMBER
     -> CHECK IF STATEMENTS TO SEE WHICH OPERATION IS PRESSED
     -> DO SUM
     -> IF SECOND NUMBER OF DIVIDE IS ZERO DONT DO DIVIDE RETURN ZERO
     -> RETURN RESULTS
       
     ----------------------------------------------
     */
    
    
    double result = 0;
    
    if([operation isEqualToString:@"+"]){
        result = firstNumber + secondNumber;  //IF OPERATION MATCHES DO THE CALCULATION
    } //end add
    

    else if ([@"x" isEqualToString:operation]) {
        result = firstNumber * secondNumber;
    }//end multiply
    
    else if ([operation isEqualToString:@"-"]){
        result = firstNumber - secondNumber;
    } //end subtract
    
    else if ([operation isEqualToString:@"÷"]){
        if (secondNumber) { result = firstNumber / secondNumber; }
        else { result = NAN; } //IF NOT A NUMBER THEN SET RESULT TO NAN
    }//end divide
  
    return result;
}


/***************************************************************************************
            RETURNS LAST NUMBER IN DISPLAY
 ***************************************************************************************/


- (double) getLastNumber: (NSString *)calculation{
    
    /* THINKING
     =============================================
     
     -> SEPERATE THE CALCULATION INTO ARRAYS
     -> CONVERT LAST NUMBER INTO A DOUBLE
     -> RETURN THE DOUBLE
     
     ----------------------------------------------
     */
    
    
    NSArray *numbers =  [calculation componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@" "]];  //SEPERATES THE STRING INTO ARRAYS
    
    NSLog(@"Calculation Array: %@", numbers);
    
    
    
   double lastNum = [ [numbers lastObject] doubleValue]; //GETS LAST NUMBER
   // NSLog(@"last %g", lastNum);
    
    return lastNum; //RETURNS LAST NUMBER
}

/***************************************************************************************
            CLEARS LAST ENTERED DIGIT
 ***************************************************************************************/

- (NSString *) cButton:(NSString *)calculation{
    
    /* THINKING
     =============================================
     
     -> SEPERATE THE CALCULATION INTO ARRAYS
     -> REMOVE LAST ARRAY
     -> JOIN THE ARRAYS BACK TOGETHER INTO A STRING SEPERATING BY " "
     -> RETURN STRING
     
     ----------------------------------------------
     */
    
    NSArray *numbers =  [calculation componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    NSMutableArray *newCal = [numbers mutableCopy]; //MAKES A MUTABLE COPY
    
    [newCal removeLastObject]; //REMOVES LAST OBJECT

    NSString *lastRemoved = [newCal componentsJoinedByString:@" "]; //REJOINS STRING
    
    return lastRemoved; //RETURNS NEW EDITED STRING
}

/***************************************************************************************
            CHECKS FOR DECIMALS
 ***************************************************************************************/

- (BOOL) containsDecimalPoint:(double)num{
    
    /* THINKING
     =============================================
     
     -> CHANGE THE NUMBER INTO STRING
     -> CHECK IF THE NUMBER HAS DECIMAL IN IT
     -> IF IT HAS THEN RETURN TRUE
     -> IF IT DOESNT RETURN FALSE
     
     ----------------------------------------------
     */
    
    NSLog(@"cNumber (model) = %g",num);
    
    NSString *number = [NSString stringWithFormat:@"%g",num]; 
    NSLog(@"%@", number);
    
    NSCharacterSet *decimal = [NSCharacterSet characterSetWithCharactersInString:@"."];
    BOOL search = [number rangeOfCharacterFromSet:decimal].location!=NSNotFound;
    NSLog(search ? @"decimal Yes" : @"decimal No");
    
    return search;
}


/***************************************************************************************
            "0." Decimal Fix
 ***************************************************************************************/

- (BOOL) zeroDecimalFix:(NSString *)calculation{
    
    /* THINKING
     =============================================
     
     -> SEPERATE THE DISPLAY INTO ARRAYS
     -> GET CURRENT OBJECT
     -> RETURN TRUE IF IT HAS 0.
     -> RETURN FALSE IF IT DOESNT HAVE IT.
     
     ----------------------------------------------
     */
    
    

    NSArray *numbers =  [calculation componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@" "]];
    NSCharacterSet *decimal = [NSCharacterSet characterSetWithCharactersInString:@"."];

    
    if ([[numbers lastObject] rangeOfCharacterFromSet:decimal].location != NSNotFound){
        return true;
    }
         else return false;
    
}

/***************************************************************************************
            1/X RETURN
 ***************************************************************************************/

- (double) doOneOverX:(double)xValue
{
    double reciprocal = 1 / xValue;
    return reciprocal;
}


/***************************************************************************************
            SQUARE NUMBER RETURN
 ***************************************************************************************/

- (double) doSquare:(double)xValue{

    double square = xValue * xValue;
    return square;
}


/***************************************************************************************
            SQUARE ROOT NUMBER RETURN
 ***************************************************************************************/

- (double) doSquareRoot:(double)xValue{
    
    double squareRoot = sqrt(xValue);
    return squareRoot;
    
    
}

/***************************************************************************************
            DO LOG NUMBER RETURN
 ***************************************************************************************/

- (double) doLog:(double)xValue
{
    double logValue = log10(xValue);
    return logValue;
}

/***************************************************************************************
            DO LN NUMBER RETURN
 ***************************************************************************************/

- (double) doLn:(double)xValue
{
    double lnValue = log(xValue);
    return lnValue;
}

/***************************************************************************************
            RETURN PI
 ***************************************************************************************/

- (double) getPI
{
    NSString *pi_rounded = [NSString stringWithFormat:@"%1.8f", M_PI];
    
  //  NSLog(pi_rounded);
    
    double pi = [pi_rounded doubleValue];
    return pi;
}

/***************************************************************************************
            DO SINE
 ***************************************************************************************/


- (double) doSine:(double)xValue :(BOOL)radians
{
    double sineValue;
    
    if (radians == NO){
        xValue = DEGREES_TO_RADIANS(xValue);
    }
    
    sineValue = sin(xValue);
    
        return sineValue;
}

/***************************************************************************************
            DO ARCSINE
 ***************************************************************************************/

- (double) doArcSine:(double)xValue :(BOOL)radians
{
    double aSineValue;
    
    if (radians == NO){
        aSineValue = RADIANS_TO_DEGREES(asin(xValue));
    }
    else {
        aSineValue = asin(xValue);
    }
    
    return aSineValue;
}

/***************************************************************************************
            DO COS
 ***************************************************************************************/

- (double) doCos:(double)xValue :(BOOL)radians
{
    double cosValue;
    
    if (radians == NO){
        xValue = DEGREES_TO_RADIANS(xValue);
    }
    
    cosValue = cos(xValue);
    return cosValue;
}

/***************************************************************************************
            DO ARCCOS
 ***************************************************************************************/

- (double) doArcCos:(double)xValue :(BOOL)radians
{
    double aCosValue;
    
    NSLog(@"%@",radians ? @"YES" : @"NO");
    
    if (radians == NO){
        aCosValue = RADIANS_TO_DEGREES(acos(xValue));
    }
    else {
    aCosValue = acos(xValue);
    }
    
    return aCosValue;
}

/***************************************************************************************
            DO TAN
 ***************************************************************************************/

- (double) doTan:(double)xValue :(BOOL)radians
{
    double tanValue;
    
    if (radians == NO){
        xValue = DEGREES_TO_RADIANS(xValue);
    }
    
    tanValue = tan(xValue);
    return tanValue;
}

/***************************************************************************************
            DO ARCTAN
 ***************************************************************************************/

- (double) doArcTan:(double)xValue :(BOOL)radians
{
    double aTanValue;
    
    if (radians == NO){
        aTanValue = RADIANS_TO_DEGREES(atan(xValue));
    }
    else {
    aTanValue = atan(xValue);
    }
        
    return aTanValue;
}

- (NSString *) doPositiveNegativeOnLastNumber:(NSString *)calculation
{
    NSArray *numbers =  [calculation componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@" "]];
    
    double convert = [self doPositiveNegative:[[numbers lastObject] doubleValue]]; //CHANGE SIGN OF LAST OBJECT
    
    
    NSMutableArray *newNumbers = [[NSMutableArray alloc]init]; //NEW ARRAY
    
    newNumbers = [numbers mutableCopy]; //COPY OLD ARRAY
    
    [newNumbers removeLastObject]; //REMOVE LAST OBJECT
    
    [newNumbers addObject:[NSString stringWithFormat:@"%g",convert]]; //ADD NEW CONVERTED OBJECT
    
    NSString *newCalculation =   [newNumbers componentsJoinedByString:@" "]; //CREATE STRING
    
   // NSLog(newCalculation);
    return newCalculation; //RETURN STRING
}


/***************************************************************************************
            DO POSITIVE NEGATIVE
 ***************************************************************************************/
- (double) doPositiveNegative:(double)xValue
{
    double positiveNegative = xValue * (-1);
    return positiveNegative;
}

/***************************************************************************************
            DO PERCENTAGE
 ***************************************************************************************/
- (double) doPercentage:(NSString *)operation :(double)firstNumber :(double)secondNumber{
    
    double result = 0;
    
    if([operation isEqualToString:@"+"]){
        result = firstNumber * (secondNumber / 100);
        result = firstNumber + result;
    } //end add
    
    else if ([@"x" isEqualToString:operation]) {
        result = firstNumber * secondNumber / 100;
        result = firstNumber + result;
    }//end multiply
    
    else if ([operation isEqualToString:@"-"]){
        result = firstNumber - secondNumber / 100;
        result = firstNumber - result;
    } //end subtract
    
    else if ([operation isEqualToString:@"÷"]){
        if (secondNumber) { result = firstNumber / secondNumber / 100; }
            else { result = NAN;}
    }//end divide
    
    return result;
}


@end
