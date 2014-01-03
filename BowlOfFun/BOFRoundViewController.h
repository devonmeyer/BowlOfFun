//
//  BOFRoundViewController.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOFItem, BOFGame;

@interface BOFRoundViewController : UIViewController
{
    
    __weak IBOutlet UILabel *activeTeamLabel;

    __weak IBOutlet UILabel *activePlayerLabel;
    
    __weak IBOutlet UILabel *roundNumberLabel;
    
    __weak IBOutlet UILabel *roundDescriptionLabel;

    __weak IBOutlet UIButton *playButton;

    __weak IBOutlet UILabel *itemLabel;

    __weak IBOutlet UILabel *timeLabel;

    __weak IBOutlet UIButton *gotItButton;

    __weak IBOutlet UILabel *teamFirstScoreLabel;

    __weak IBOutlet UILabel *teamSecondScoreLabel;
    
    
    int numberOfPlayers;
    NSMutableSet * masterList;
    NSMutableArray * itemsInBowl;
    NSMutableArray * itemsOutOfBowl;
    
    BOFItem * activeItem;
    
    int teamFirstScore;
    int teamSecondScore;
    int round;
    int timeLeft;
    int activePlayer;
    int activeTeam;
    int playersPerTeam;
    
    NSTimer *timer;
    int secondsLeft;


}


@property (nonatomic, weak) BOFGame * game;

@property (nonatomic, weak) UIViewController * presentingViewController;

- (id) initWithGame:(BOFGame *) theGame;

- (IBAction)playButtonPressed:(id)sender;

- (IBAction)gotItButtonPressed:(id)sender;


- (void) updateTimerText:(NSString *)timerText;

- (void) refreshView;

- (void) performTransition;


@end
