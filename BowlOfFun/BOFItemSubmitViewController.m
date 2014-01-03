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

    if ([[sender text] length] > 0 ) {
        
        [[self game] addPlayerItemWithString:[sender text]];
        
        if ([self makeTransition]) {
            
            [self performTransition];
            
        } else {
            
            [self refreshView];
            
        }
    }
}

- (IBAction)didEndEnteringName:(id)sender
{
    if ([[sender text] length] > 0 ) {        
        
        [[self game] setActivePlayerName:[sender text]];
        
        [self refreshView];
        
    }
    
}

- (void) refreshView
{
    [itemTextField becomeFirstResponder];
    [itemTextField setText:@""];
    
    [activeTeamLabel setText:[[self game] activeTeamString]];
    
    NSString * name = [[self game] activePlayerString];
        
    if ([name isEqualToString:[NSString stringWithFormat:@"Player %d", [[self game] activePlayerNumber]]]) {
        [activePlayerTextField setEnabled:YES];
        [activePlayerTextField setText:@""];
        [activePlayerTextField setPlaceholder:name];
    } else {
        [activePlayerTextField setText:name];
        [activePlayerTextField setEnabled:NO];
    }
    
    [remainingItemsLabel setText:[[self game] itemsRemainingForActivePlayerString]];
    
}

- (void) performTransition
{
    
    [[self game] gameRoundOne];
    
    [self setMakeTransition:NO];
    
    [self presentViewController:[[self game] roundView] animated:YES completion:nil];
    
}

@end
