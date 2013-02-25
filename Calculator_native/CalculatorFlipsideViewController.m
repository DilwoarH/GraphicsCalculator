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

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //core data stuff
    CalculatorAppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    context = [appdelegate managedObjectContext];

        [self getTapeData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}


- (void) getTapeData
{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if (matchingData.count <= 0){
    
        [self.textView setText:@"None Found"];
    
    }else {
        
       NSMutableArray *display_tape = [[NSMutableArray alloc]init];
        NSString *tape_current;
        
        for (NSManagedObject *obj in matchingData)
        {
            tape_current = [obj valueForKey:@"calculation"];
            [display_tape addObject:tape_current];
        }
        
        NSString *calculations = [display_tape componentsJoinedByString:@"\n"];
        
        [self.textView setText:calculations];
        
        NSLog(@"%@", display_tape);
    }


}

- (IBAction)clearData:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Calculation" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    for (NSManagedObject *obj in matchingData)
    {
        [context deleteObject:obj];
    }
    
    [context save:&error];
    
    [self.textView setText:@"Calculations Deleted."];
    
}




@end
