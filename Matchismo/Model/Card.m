//
//  Card.m
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import "Card.h"

@interface Card()//use for private variables
@end

@implementation Card

//0 is NIL and is BOOL value NO
/*
 - (int)match:(Card *)card
 {
 int score = 0;
 
 //card.contents is calling the getter for the card that was passed as the argument to this method
 //calling a getting again at self.contents, to send getting to self to get contents, both return
 //SENDING MESSAGES IN OBJECTIVE-C: [from_variable (message): (arguments)]
 if ([card.contents isEqualToString:self.contents])
 {
 score = 1;
 }
 return score;
 }*/


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {//checks array
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end