//
//  BOFGameViewController.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFGameViewController.h"
#import "BOFItemSubmitViewController.h"
#import "BOFItem.h"
#import "BOFGame.h"

@implementation BOFGameViewController

@synthesize game;

- (id) initWithGame:(BOFGame *)theGame
{
    self = [super initWithNibName:@"BOFGameViewController" bundle:nil];
    
    if (self) {
        [self setGame:theGame];
    }
    return self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initWithGame:" userInfo:nil];
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

- (IBAction)playerSliderValueChanged:(UISlider *)sender
{
    
    int sliderValue = (int) [sender value];
    
    int labelValue = (int) [playerNumberLabel text];
    
    if (sliderValue != labelValue && !(sliderValue % 2) && sliderValue >= 4){
        [playerNumberLabel setText:[NSString stringWithFormat:@"%d", sliderValue]];
    }
    
    
    
}

- (IBAction)playButtonPressed:(id)sender {
    
    [[self game] setNumberOfPlayers:[[playerNumberLabel text] intValue]];
    
    // Add item addition screen
    
    [[self game] gameEnteringItems];
    
    [self presentViewController:[[self game]itemView] animated:YES completion:nil];
    
    
}

@end
