//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Gabor on 2014-05-08.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
//readwrite is the default, input here because read only in public
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;//of Card
@property (readwrite, nonatomic) NSMutableString *results;//assignment #1
@property (nonatomic) int mode;//mode for 2-card or 3-card game
@end

@implementation CardMatchingGame

//lazy instantiation
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable) {
        if (!card.faceUp) {
            NSLog(@"first card");
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUP && !otherCard.isUnplayable){
                    NSLog(@"second card");
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        //assignment #1
                        //NSLog(@"Matched %@ & %@ for %i points!",card.contents,otherCard.contents,MATCH_BONUS);
                        _results = [[NSMutableString alloc] initWithFormat:@"Matched %@ & %@ for %i points!",card.contents,otherCard.contents,MATCH_BONUS];
                    }else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        //assignment #1
                        //NSLog(@"%@ and %@ don't match! %i point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY);
                        _results = [[NSMutableString alloc] initWithFormat:@"%@ and %@ don't match! %i point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                    }
                    break;
                }
                //NSLog(@"Flippd up %@",card.contents);
                _results = [[NSMutableString alloc] initWithFormat:@"Flippd up %@",card.contents];
            }
        }
        self.score -= FLIP_COST; //flip cost deduction
        card.faceUp = !card.isFaceUP;//Flips card back over
    }
}

//---------------------------------------------------------//
//Assignment #1
//*****LEFT OFF HERE, WAS TRYING TO FIGURE OUT HOW TO PROPERLY STORE ALL THREE CARDS THEN RUN MATCH ON IT*****//
- (void)flipCardAtIndex3:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable){
        if (!card.faceUp){
            NSLog(@"first card");
            
            for (Card *secondCard in self.cards){
                if (secondCard && !secondCard.isUnplayable){
                    if (!secondCard.faceUp) {
                        NSLog(@"second card");
                        
                        for (Card *thirdCard in self.cards){
                            if (thirdCard.isFaceUP && !thirdCard.isUnplayable){
                                NSLog(@"third card");
                                NSLog(@"card1: %@, card2: %@, card3: %@",card.contents,secondCard.contents,thirdCard.contents);
                                break;
                            }
                        }
                    break;
                    }
                }
            }
            card.faceUp = !card.isFaceUP;//Flips card back over
        }
    }
}
//---------------------------------------------------------//
//returns the index of the card in the array inwhich the cards are stored
- (Card *)cardAtIndex:(NSUInteger)index
{//count is not a property, it's a method so use message sending
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

//intializes the array of playing cards
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{//if using convenience intializer then use self = [self init]
    self = [super init];
    self.score = 0;
    _results = [[NSMutableString alloc] initWithFormat:@"Welcome to Machismo!"];
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card) {
            self.cards[i] = card;//need lazy instantiation because don't want to pull a nil card, would cause program to crash
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end