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

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
