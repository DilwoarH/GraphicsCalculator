//
//  TableViewController.h
//  Calculator_native
//
//  Created by Dilwoar Hussain on 24/02/2013.
//  Copyright (c) 2013 Dilwoar Hussain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *myTableView;
    NSMutableArray *array;
}

@end
