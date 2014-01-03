//
//  BOFItem.m
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "BOFItem.h"

@implementation BOFItem

@synthesize itemString;

- (id) initWithString:(NSString *)theString
{
    self = [super init];
    
    if (self) {
        
        [self setItemString:theString];
        
    }
    
    return self;
    
}

- (NSString *) description
{
    
    return [NSString stringWithFormat:@"Item : %@", itemString];
    
}

@end
