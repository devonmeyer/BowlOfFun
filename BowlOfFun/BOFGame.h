//
//  BOFGame.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//


/*
 
 
 TODO
 - Settings panel for changing...
        Time Limits
        Items per person
        
 - Allow players to identify themselves by name
 - Allow teams to identify themselves by team name
 
 
 
 
 
 
 
 
 
 
 */

#import <Foundation/Foundation.h>
@class BOFGameViewController, BOFItemSubmitViewController, BOFRoundViewController, BOFItem, BOFGameOverViewController;

static int itemsPerPerson = 6;

@interface BOFGame : NSObject

typedef enum gameRoundTypes
{
    ENTERING_ITEMS,
    ROUND_ONE,
    ROUND_TWO,
    ROUND_THREE,
    FINISHED,
    SELECTING_PLAYERS,

} GameRound;

// Properties

@property (nonatomic) int numberOfPlayers;

@property (nonatomic) int activeTeamNumber;

@property (nonatomic) int activePlayerNumber;

@property (nonatomic) int firstTeamScore;

@property (nonatomic) int secondTeamScore;

@property (nonatomic) int itemsRemainingForActivePlayer;

@property (nonatomic) GameRound round;

@property (nonatomic) NSTimer * timer;

@property (nonatomic) int secondsRemaining;

@property (nonatomic) int playersPerTeam;

@property (nonatomic) int winningTeam;

@property (nonatomic) NSMutableSet * masterList;

@property (nonatomic) NSMutableArray * bowl;

@property (nonatomic) NSMutableArray * table;

@property (nonatomic) BOOL active;

@property (nonatomic, weak) BOFItem * activeItem;

@property (nonatomic, strong) BOFGameViewController * gameView;

@property (nonatomic, strong) BOFItemSubmitViewController * itemView;

@property (nonatomic, strong) BOFRoundViewController * roundView;

@property (nonatomic, strong) BOFGameOverViewController * gameOverView;

// Controller Messages

- (void) newGame;

- (void) gameEnteringItems;

- (void) gameRoundOne;

- (void) gameRoundTwo;

- (void) gameRoundThree;

- (void) gameFinished;

- (void) addPlayerItemWithString:(NSString *)string;

- (NSString *) itemsRemainingForActivePlayerString;

- (NSString *) activePlayerNumberString;

- (NSString *) activeTeamNumberString;

- (NSString *) firstTeamScoreString;

- (NSString *) secondTeamScoreString;

- (NSString *) activeRoundString;

- (NSString *) activeRoundDescriptionString;

- (NSString *) activeItemString;

- (NSString *) timeRemainingString;

- (NSString *) winningTeamString;

- (NSString *) finalScoreString;

- (void) setPlaying;

- (void) getItemFromBowl;

- (void) itemGuessed;




@end
