//
//  Deck.m
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import "Deck.h"

@interface Deck()
//NSMutableArray: is a subclass of array, can modify array if mutable (add to array method included)
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

//lazy instantiation, keeps it from returning nil
//alloc is the message sent to allocate memory in the heap, the init is a seperate message sent to initialize the array
//never seperate alloc and an init, you will get into trouble by doing that, alloc is a class method
//Mutable arrays are dynamic allocation
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//need to protect against a nil with "if NIL" statement
- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

//self (or "this" in some languages) is a pointer to the object that the code is executing in
- (Card *)drawRandomCard
{
    Card *randomCard = nil; //local variables start of as zero, if objects then start off as nil
    
    if (self.cards.count){//checks to make sure there aren't "nil" cards on the deck
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end