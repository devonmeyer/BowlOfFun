//
//  BOFGameOverViewController.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BOFGame;

@interface BOFGameOverViewController : UIViewController
{
    
    __weak IBOutlet UILabel *winningTeamLabel;
    
    __weak IBOutlet UILabel *finalScoreLabel;
    
    
}

@property (nonatomic, weak) BOFGame * game;

- (id) initWithGame:(BOFGame *) theGame;

- (IBAction)playAgainPressed:(id)sender;

- (void) performTransition;



@end
