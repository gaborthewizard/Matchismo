//
//  Playingcard.m
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

#define MATCH_2_SUITS 1
#define MATCH_3_SUITS 3
#define MATCH_2_RANK 2
#define MATCH_3_RANK 6

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if ( [otherCards count] == 1){//lastObject never gives you out of bounds, returns nil if array empty
        PlayingCard *otherCard = [otherCards lastObject];
        NSLog(@"2 cards: (1) %@, (2) %@", self.contents, otherCard.contents);
        if ([otherCard.suit isEqualToString:self.suit]){
            score = MATCH_2_SUITS*2;
        } else if (otherCard.rank == self.rank) {
            score = MATCH_2_RANK*2;
        }
    }
    
    if ( [otherCards count] == 2){//need to figure out how to change card number
        PlayingCard *secondCard = [otherCards objectAtIndex:0];
        PlayingCard *thirdCard = [otherCards objectAtIndex:1];
        NSLog(@"3 cards: (1) %@, (2) %@, (3) %@", self.contents, secondCard.contents, thirdCard.contents);
        if ([secondCard.suit isEqualToString:self.suit] || [thirdCard.suit isEqualToString:self.suit] || [secondCard.suit isEqualToString:thirdCard.suit]){
            score = MATCH_2_SUITS;
            NSLog(@"MATCH_2_SUITS");
        } else if ([secondCard.suit isEqualToString:self.suit] && [thirdCard.suit isEqualToString:self.suit]) {
            score = MATCH_3_SUITS;
            NSLog(@"MATCH_3_SUITS");
        } else if (secondCard.rank == self.rank || thirdCard.rank == self.rank || secondCard.rank == thirdCard.rank){
            score = MATCH_2_RANK;
            NSLog(@"MATCH_2_RANK");
        } else if ( secondCard.rank == self.rank && thirdCard.rank == self.rank) {
            score = MATCH_3_RANK;
            NSLog(@"MATCH_3_RANK");
        }
    }
    return score;
}


- (NSString *)contents{
    //@[] create an array on the fly, NSArray there immutable
    //@"" create strings on the fly
    //objects in an array can be any class, do not need to be specified
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //because we provide the setter AND getter

//dashes are sent to instances of a class
//pluses are sent to a class, you would send a message to a classes for utilitiy methods
+ (NSArray *)validSuits {
    return @[@"♠",@"♦",@"♥",@"♣"];
}

- (void)setSuit:(NSString *)suit{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank{ return [self rankStrings].count-1;}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
