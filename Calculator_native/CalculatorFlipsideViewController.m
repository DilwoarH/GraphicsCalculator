//
//  CalculatorFlipsideViewController.m
//  Calculator_native
//
//  Created by Dilwoar Hussain on 18/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import "CalculatorFlipsideViewController.h"
#import "CalculatorAppDelegate.h"




@interface CalculatorFlipsideViewController ()
{
    
    NSManagedObjectContext *context;
    
}


@end

@implementation CalculatorFlipsideViewController

/***************************************************************************************
        AWAKE FROM NIB
 ***************************************************************************************/

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/***************************************************************************************
        VIEW DID LOAD
 ***************************************************************************************/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //core data stuff
    CalculatorAppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];

        [self getTapeData];

}

/***************************************************************************************
        DID RECIEVE WARNING FUNCTION
 ***************************************************************************************/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/***************************************************************************************
        DONE BUTTON
 ***************************************************************************************/

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

/***************************************************************************************
        GETS DATA FROM THE DATABASE
 ***************************************************************************************/

- (void) getTapeData
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <= 0){
    
        [self.textView setText:@"None Found"]; //IF NO MATCH THEN RETURN NONE FOUND
    
    }else {
        
       NSMutableArray *display_tape = [[NSMutableArray alloc]init];
        NSString *tape_current;
        
        for (NSManagedObject *obj in matchingData)
        {
            tape_current = [obj valueForKey:@"calculation"];
            [display_tape addObject:tape_current]; //ADD RESULTS INTO ARRAY
        }
        
        NSString *calculations = [display_tape componentsJoinedByString:@"\n"]; //START NEW LINE
        
        [self.textView setText:calculations]; //SET TO TEXT VIEW
        
        NSLog(@"%@", display_tape);
    }


}

/***************************************************************************************
        CLEAR THE DATA
 ***************************************************************************************/

- (IBAction)clearData:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *obj in matchingData)
    {
        [context deleteObject:obj]; //DELETE EACH OBJECT FOUND
    }
    
    [context save:&error];
    
    [self.textView setText:@"Calculations Deleted."];
    
}




@end
