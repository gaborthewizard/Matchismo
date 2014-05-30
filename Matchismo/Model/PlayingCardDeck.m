//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import "PlayingCardDeck.h"


@implementation PlayingCardDeck

//returns a playing cardDeck *... id is a pointer to object of any class, initilizers always return id
- (id)init
{
    self = [super init];//only time you'd equal to init
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end
