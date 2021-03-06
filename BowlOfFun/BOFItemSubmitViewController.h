//
//  BOFItemSubmitViewController.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BOFGameViewController, BOFItem, BOFGame;

@interface BOFItemSubmitViewController : UIViewController
<UITextFieldDelegate>
{
    
    __weak IBOutlet UILabel *activeTeamLabel;
    
    __weak IBOutlet UITextField *activePlayerTextField;
    
    __weak IBOutlet UILabel *remainingItemsLabel;
    
    __weak IBOutlet UITextField *itemTextField;
    

    
}

@property (nonatomic, weak) BOFGame * game;

@property (nonatomic) BOOL makeTransition;

- (id) initWithGame:(BOFGame *)theGame;

- (IBAction)didEndEditing:(id)sender;

- (IBAction)didEndEnteringName:(id)sender;

@end
