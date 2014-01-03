//
//  BOFRoundViewController.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFRoundViewController.h"
#import "BOFItem.h"
#import "BOFGame.h"
#import "BOFGameOverViewController.h"

@implementation BOFRoundViewController

@synthesize presentingViewController;

- (id) initWithGame:(id)theGame
{
    self = [super initWithNibName:@"BOFRoundViewController" bundle:nil];

    if (self) {
        
        [self setGame:theGame];
        
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initWithGame" userInfo:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshView {
    
    if ([[self game] active]) {
        
        [playButton setHidden:YES];
        [itemLabel setHidden:NO];
        [timeLabel setHidden:NO];
        [gotItButton setHidden:NO];
        
        [itemLabel setText:[[self game] activeItemString]];
        [timeLabel setText:[[self game] timeRemainingString]];
        
    } else {
        
        [teamNumberLabel setText:[[self game] activeTeamNumberString]];
        [playerNumberLabel setText:[[self game] activePlayerNumberString]];
        
        [roundNumberLabel setText:[[self game] activeRoundString]];
        [roundDescriptionLabel setText:[[self game] activeRoundDescriptionString]];
        [playButton setHidden:NO];
        [itemLabel setHidden:YES];
        [timeLabel setHidden:YES];
        [gotItButton setHidden:YES];
        [teamFirstScoreLabel setText:[[self game] firstTeamScoreString]];
        [teamSecondScoreLabel setText:[[self game] secondTeamScoreString]];
        
        if ( [[self game] activeTeamNumber] == 1 ) {
            [teamFirstScoreLabel setTextColor:[UIColor blackColor]];
            [teamSecondScoreLabel setTextColor:[UIColor lightGrayColor]];
        } else {
            [teamSecondScoreLabel setTextColor:[UIColor blackColor]];
            [teamFirstScoreLabel setTextColor:[UIColor lightGrayColor]];

        }
    }
    
}

- (IBAction)playButtonPressed:(id)sender
{
    
    [self setPlaying];
    
}

- (IBAction)gotItButtonPressed:(id)sender
{
    
    [[self game] itemGuessed];
    [itemLabel setText:[[self game] activeItemString]];
    [teamFirstScoreLabel setText:[[self game] firstTeamScoreString]];
    [teamSecondScoreLabel setText:[[self game] secondTeamScoreString]];
    
    
}

- (void) setPlaying
{
    [[self game] setPlaying];
    
    [self refreshView];
    
}

- (void) updateTimerText:(NSString *)timerText
{
    
    [timeLabel setText:timerText];
    
}

- (void) performTransition
{
    
    [self presentViewController:[[self game] gameOverView] animated:YES completion:nil];
    
}




@end
