//
//  ViewController.m
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

/*
 3. Add a text label somewhere which describes the results of the last flip.
 Examples:
    "Matched J(heart) and J(spade) for 4 points."
    "6(diamond) and J(clubs) don't match! 2 point penalty!"
    "Flipped up 8(diamond)" if no match.
 4. Add a button called Deal...
 */

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentController;
@end

@implementation ViewController

//lazy instantiation (needed to alloc and init)
- (CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons;
    [self updateUI];
    /*for (UIButton *cardButton in cardButtons){
        Card *card = [self.deck drawRandomCard];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        //[cardButton setTitle:@"HELLO?" forState:UIControlStateSelected];
    }*/
}

//controllers fundemental job is to make sure the model matches the UI
- (void)updateUI
{
    for (UIButton *cardbutton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardbutton]];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected];
        [cardbutton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardbutton.selected = card.isFaceUP;
        cardbutton.enabled = !card.isUnplayable;
        cardbutton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultsLabel.text = [NSString stringWithFormat:@"%@", self.game.results];
}

- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

//flipCardAtIndex is the main function of the game, would have to call other IBACTION if in other game mode... check game mode to decide which is occuring?
- (IBAction)flipCard:(UIButton *)sender {
    //model decides what is in selected state
    //sender.selected = !sender.isSelected;
    //tell model to flip card, asking array of card buttons of index of that object
    if( _segmentController.selectedSegmentIndex == 0) {[_segmentController setEnabled:NO forSegmentAtIndex:1];}
    if( _segmentController.selectedSegmentIndex == 1) {[_segmentController setEnabled:NO forSegmentAtIndex:0];}
    
    if( _segmentController.selectedSegmentIndex == 0) {
        NSLog(@"2-card");
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        self.flipCount++;
    }
    if( _segmentController.selectedSegmentIndex == 1) {
        NSLog(@"3-card");
        [self.game flipCardAtIndex3:[self.cardButtons indexOfObject:sender]];
        self.flipCount++;
    }
    [self updateUI];
}

- (IBAction)dealButton:(UIButton *)sender {
    NSLog(@"dealButton pressed");
    _game = [self.game initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    [self updateUI];
    [self setFlipCount:0];
    [_segmentController setEnabled:YES forSegmentAtIndex:0];
    [_segmentController setEnabled:YES forSegmentAtIndex:1];
}

- (IBAction)gameModeSwitcher:(UISegmentedControl *)sender {
    if( _segmentController.selectedSegmentIndex == 0) {[_segmentController setEnabled:NO forSegmentAtIndex:1];}
    if( _segmentController.selectedSegmentIndex == 1) {[_segmentController setEnabled:NO forSegmentAtIndex:0];}
}

@end