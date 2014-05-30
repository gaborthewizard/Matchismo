//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Gabor on 2014-05-08.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Don't know how many cards we're going to use so can't use straight init
//designated initializer (must use comment, cannot convey any other way), other type of initializer is convenience intializer
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

//3-card implementation
- (void)flipCardAtIndex3:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

//readonly means that there is only a getter and no setter
@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSMutableString *results;

@end
