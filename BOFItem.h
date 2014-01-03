//
//  BOFItem.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOFItem : NSObject

@property (nonatomic, copy) NSString * itemString;

- (id) initWithString:(NSString *) theString;

@end
