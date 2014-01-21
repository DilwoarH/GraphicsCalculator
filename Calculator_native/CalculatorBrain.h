//
//  CalculatorBrain.h
//  Calculator_native
//
//  Created by Dilwoar Hussain on 20/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (double) doCalculation:(NSString *)operation :(double)firstNumber :(double)secondNumber;
- (double) getLastNumber:(NSString *)calculation;
- (NSString *) cButton:(NSString *)calculation;
- (BOOL) containsDecimalPoint:(double)num;
- (BOOL) zeroDecimalFix:(NSString *)calculation;

- (double) doOneOverX:(double)xValue;
- (double) doSquare:(double)xValue;
- (double) doSquareRoot:(double)xValue;
- (double) doLog:(double)xValue;
- (double) doLn:(double)xValue;
- (double) getPI;
- (double) doSine:(double)xValue :(BOOL)radians;
- (double) doArcSine:(double)xValue :(BOOL)radians;
- (double) doCos:(double)xValue :(BOOL)radians;
- (double) doArcCos:(double)xValue :(BOOL)radians;
- (double) doTan:(double)xValue :(BOOL)radians;
- (double) doArcTan:(double)xValue :(BOOL)radians;
- (double) doPositiveNegative:(double)xValue;
- (double) doPercentage:(NSString *)operation :(double)firstNumber :(double)secondNumber;
- (NSString *) doPositiveNegativeOnLastNumber:(NSString *)calculation;

@end
