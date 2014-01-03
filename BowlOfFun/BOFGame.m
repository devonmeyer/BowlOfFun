//
//  BOFGame.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFGame.h"
#import "BOFItem.h"
#import "BOFGameViewController.h"
#import "BOFItemSubmitViewController.h"
#import "BOFRoundViewController.h"
#import "BOFGameOverViewController.h"
#import <AudioToolbox/AudioServices.h>

@implementation BOFGame

@synthesize numberOfPlayers, activePlayerNumber, activeTeamNumber, firstTeamScore, secondTeamScore, round, timer, secondsRemaining, playersPerTeam, masterList, bowl, table, gameView, itemView, roundView, itemsRemainingForActivePlayer, active, activeItem, winningTeam, gameOverView;


- (id) init
{
    self = [super init];
    
    if (self) {
        numberOfPlayers = 0;
        activePlayerNumber = 1;
        activeTeamNumber = 1;
        firstTeamScore = 0;
        secondTeamScore = 0;
        round = SELECTING_PLAYERS;
        timer = nil;
        secondsRemaining = 60;
        itemsRemainingForActivePlayer = itemsPerPerson;
        playersPerTeam = 0;
        [self setMasterList:[[NSMutableSet alloc] init]];
        [self setBowl:[[NSMutableArray alloc] init]];
        [self setTable:[[NSMutableArray alloc] init]];
        
        [self setGameView:[[BOFGameViewController alloc] initWithGame:self]];
        [self setItemView:[[BOFItemSubmitViewController alloc] initWithGame:self]];
        [self setRoundView:[[BOFRoundViewController alloc] initWithGame:self]];
        
    }
    
    return self;
    
}

- (void) newGame
{
    
    [self setNumberOfPlayers:0];
    [self setActivePlayerNumber:1];
    [self setActiveTeamNumber:1];
    [self setFirstTeamScore:0];
    [self setSecondTeamScore:0];
    [self setRound:SELECTING_PLAYERS];
    [self endTimer];
    [self setSecondsRemaining:60];
    [self setItemsRemainingForActivePlayer:itemsPerPerson];
    [self setPlayersPerTeam:0];
    [self setMasterList:[[NSMutableSet alloc] init]];
    [self setBowl:[[NSMutableArray alloc] init]];
    [self setTable:[[NSMutableArray alloc] init]];
    
    [self setGameView:[[BOFGameViewController alloc] initWithGame:self]];
    [self setItemView:[[BOFItemSubmitViewController alloc] initWithGame:self]];
    [self setRoundView:[[BOFRoundViewController alloc] initWithGame:self]];
    
    [[self gameOverView] performTransition];
}

- (void) gameEnteringItems
{
    
    [self setRound:ENTERING_ITEMS];
    [self setActivePlayerNumber:1];
    [self setActiveTeamNumber:1];
    [self setItemsRemainingForActivePlayer:itemsPerPerson];
    [self setPlayersPerTeam:([self numberOfPlayers] / 2)];
    [self setMasterList:[[NSMutableSet alloc] init]];
    
    if (! [self itemView] ) {
        [self setItemView:[[BOFItemSubmitViewController alloc] initWithGame:self]];
    }
    
}

- (void) gameRoundOne
{
    [self setFirstTeamScore:0];
    [self setSecondTeamScore:0];
    [self setRound:ROUND_ONE];
    [self setActivePlayerNumber:1];
    [self setActiveTeamNumber:1];
    [self setBowl:[NSMutableArray arrayWithArray:[masterList allObjects]]];
    [self setTable:[[NSMutableArray alloc] init]];
    [self setActive:NO];
    
    if (! [self roundView] ) {
        [self setRoundView:[[BOFRoundViewController alloc] initWithGame:self]];
    }
    
    [self setActiveItem:nil];
    
}

- (void) gameRoundTwo
{
    
    [self setRound:ROUND_TWO];
    [self setBowl:[NSMutableArray arrayWithArray:[masterList allObjects]]];
    [self setTable:[[NSMutableArray alloc] init]];
    [self setActive:NO];
    [self setActiveItem:nil];
}

- (void) gameRoundThree
{
    
    [self setRound:ROUND_THREE];
    [self setBowl:[NSMutableArray arrayWithArray:[masterList allObjects]]];
    [self setTable:[[NSMutableArray alloc] init]];
    [self setActive:NO];
    [self setActiveItem:nil];
    
}

- (void) gameFinished
{
    
    [self setRound:FINISHED];
    [self setActive:NO];
    
    [self setGameOverView:[[BOFGameOverViewController alloc] initWithGame:self]];
    
}

- (void) addPlayerItemWithString:(NSString *)string
{
    
    BOFItem * item = [[BOFItem alloc] initWithString:string];
    [masterList addObject:item];
    if (itemsRemainingForActivePlayer == 1) {
        [self switchPlayer];
    } else {
        itemsRemainingForActivePlayer --;
    }
    
}

- (NSString *) itemsRemainingForActivePlayerString
{
    
    return [NSString stringWithFormat:@"%d", itemsRemainingForActivePlayer];
    
}

- (NSString *) activePlayerNumberString
{
    
    return [NSString stringWithFormat:@"%d", activePlayerNumber];
    
}

- (NSString *) activeTeamNumberString
{
    
    return [NSString stringWithFormat:@"%d", activeTeamNumber];
    
}

- (NSString *) firstTeamScoreString
{
    
    return [NSString stringWithFormat:@"%d", firstTeamScore];
    
}

- (NSString *) secondTeamScoreString
{
    
    return [NSString stringWithFormat:@"%d", secondTeamScore];
    
}

- (NSString *) activeRoundString
{
    
    return [NSString stringWithFormat:@"Round : %d", round];
    
}

- (NSString *) activeRoundDescriptionString
{
    
    if ([self round] == ROUND_ONE) {
        
        return @"Describe the item with words.";
        
    } else if ([self round] == ROUND_TWO) {
        
        return @"Describe the item with gestures.";
        
    } else {
        
        return @"Describe the item with one word.";
        
    }
    
}

- (NSString *) activeItemString
{
    
    return [[self activeItem] itemString];
    
}

- (NSString *) timeRemainingString
{
    
    int minutes = ([self secondsRemaining] % 3600) / 60;
    int seconds = ([self secondsRemaining] % 3600) % 60;
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    
}

- (NSString *) winningTeamString
{
    
    if (winningTeam != 0) {
        return [NSString stringWithFormat:@"Team %d", winningTeam];
    } else {
        return @"Both Teams!";
    }
    
}

- (NSString *) finalScoreString
{
    if (winningTeam == 1){
        return [NSString stringWithFormat:@"%d - %d", firstTeamScore, secondTeamScore];
    } else {
        return [NSString stringWithFormat:@"%d - %d", secondTeamScore, firstTeamScore];
    }
    
}

- (void) setPlaying {
    
    [self setActive:YES];
    [self setTimer];
    [self getItemFromBowl];
    
}

- (void) switchPlayer
{
    [self setActive:NO];
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    if (round == ENTERING_ITEMS) {
        if (activePlayerNumber < playersPerTeam) {
            activePlayerNumber ++;
            itemsRemainingForActivePlayer = itemsPerPerson;
        } else {
            if (activeTeamNumber == 1){
                activeTeamNumber ++;
                activePlayerNumber = 1;
                itemsRemainingForActivePlayer = itemsPerPerson;
            } else {
                [[self itemView] setMakeTransition:YES];
            }
        }
    } if ((round == ROUND_ONE ) || (round == ROUND_TWO) || (round == ROUND_THREE)) {
        
        AudioServicesPlaySystemSound(1024);
        
        if (activeTeamNumber == 1) {
            
            [self setActiveTeamNumber:2];
            
        } else {
            
            [self setActiveTeamNumber:1];
            
            if (activePlayerNumber < playersPerTeam) {
                
                activePlayerNumber ++;
                
            } else {
                
                activePlayerNumber = 1;
            }
            
        }
        
        
    }
    
}

- (void) nextRound {
    
    [self endTimer];
    [self switchPlayer];
    
    if (round == ROUND_ONE) {
        
        [self gameRoundTwo];
        [[self roundView] refreshView];
        
        
    } else if (round == ROUND_TWO) {
        
        [self gameRoundThree];
        [[self roundView] refreshView];
        
    } else if (round == ROUND_THREE) {
        
        [self gameFinished];
        
        if (firstTeamScore > secondTeamScore) {
            
            [self setWinningTeam:1];
            
        } else if (secondTeamScore > firstTeamScore) {
            
            [self setWinningTeam:2];
            
        } else {
            // Tie
            
            [self setWinningTeam:0];
            
        }
        
        [self endTimer];
        [[self roundView] performTransition];
        
    }
    
}

- (void) getItemFromBowl
{
    BOFItem * item = nil;
    if ([bowl count] > 0){
        NSUInteger randomIndex = arc4random() % [bowl count];
        item = [bowl objectAtIndex:randomIndex];
        [bowl removeObjectAtIndex:randomIndex];
        
        [table addObject:item];
        
        activeItem = item;
    }
    
}

- (void) itemGuessed
{
    
    if (activeTeamNumber == 1){
        firstTeamScore ++;
    } else {
        secondTeamScore ++;
    }
    
    if ([bowl count] > 0) {
        
        [self getItemFromBowl];
        
    } else {
        
        // No more items, time to switch rounds.
        
        [self nextRound];
        
    }
    
}

- (void) setTimer
{
    
    if (round == ROUND_ONE) {
        
        [self setSecondsRemaining:60];
        
    } else if (round == ROUND_TWO) {
        
        [self setSecondsRemaining:90];
        
    } else if (round == ROUND_THREE) {
        
        [self setSecondsRemaining:30];
        
    }
    
    [self setTimer:[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimerCounter:) userInfo:nil repeats:YES]];
    
}

- (void)updateTimerCounter:(NSTimer *)theTimer {
    if([self secondsRemaining] > 0 ){
        secondsRemaining -- ;
        
        [[self roundView] updateTimerText:[self timeRemainingString]];
    }
    else {
        [self endTimer];
        if (activeItem) {
            [table removeObject:activeItem];
            [bowl addObject:activeItem];
        }
        // Switch players
        [self switchPlayer];
        // Tell round view to refresh
        [[self roundView] refreshView];
    }
}

- (void) endTimer {
    
    [timer invalidate];
    timer = nil;
    
}


@end
