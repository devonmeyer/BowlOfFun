//
//  BOFItemSubmitViewController.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFItemSubmitViewController.h"
#import "BOFItem.h"
#import "BOFGameViewController.h"
#import "BOFRoundViewController.h"
#import "BOFGame.h"



@implementation BOFItemSubmitViewController

@synthesize game, makeTransition;

- (id) initWithGame:(BOFGame *)theGame
{
    self = [super initWithNibName:@"BOFItemSubmitViewController" bundle:nil];
    if (self) {
        
        [self setGame:theGame];
        [self refreshView];
        [self setMakeTransition:NO];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initWithTeam:player:numberOfPlayers:" userInfo:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshView];
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField text] length] > 0){
        [textField resignFirstResponder];
        return YES;
    }
    return NO;
    
}

- (void) didEndEditing:(id)sender
{
    NSString * itemText = [sender text];
    
    [[self game] addPlayerItemWithString:itemText];
    
    if ([self makeTransition]) {
        [self performTransition];
    } else {
        [self refreshView];
    }
}

- (void) refreshView
{
    [itemTextField becomeFirstResponder];
    [itemTextField setText:@""];
    [playerNumberLabel setText:[[self game] activePlayerNumberString]];
    [teamNumberLabel setText:[[self game] activeTeamNumberString]];
    [remainingItemsLabel setText:[[self game] itemsRemainingForActivePlayerString]];
    
}

- (void) performTransition
{
    
    [[self game] gameRoundOne];
    
    [self setMakeTransition:NO];
    
    [self presentViewController:[[self game] roundView] animated:YES completion:nil];
    
}

@end
