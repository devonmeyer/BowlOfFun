//
//  BOFGameOverViewController.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFGameOverViewController.h"

#import "BOFGame.h"
#import "BOFGameViewController.h"

@implementation BOFGameOverViewController

@synthesize game;

- (id) initWithGame:(BOFGame *)theGame
{
    
    self = [super initWithNibName:@"BOFGameOverViewController" bundle:nil];
    
    if (self) {
        
        [self setGame:theGame];
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initWithGame" userInfo:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [winningTeamLabel setText:[[self game] winningTeamString]];
    [finalScoreLabel setText:[[self game] finalScoreString]];
    
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

- (IBAction)playAgainPressed:(id)sender
{
    
    [[self game] newGame];
    
    
}

- (void) performTransition
{
    
    [self presentViewController:[[self game] gameView] animated:YES completion:nil];
    
}
@end
