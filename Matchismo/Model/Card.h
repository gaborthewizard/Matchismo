//
//  Card.h
//  Matchismo
//
//  Created by Gabor on 2014-05-07.
//  Copyright (c) 2014 Gabor. All rights reserved.
//

//.h are header files that contain public information

//#import is the same as #include in c++
//the foundation library is the basic library that contains most functions we will needs, it is precompiled so does not slow the system down... arrays etc..
#import <Foundation/Foundation.h>

//NSObject is a superclass that will usually be used
@interface Card : NSObject


//at property function declares the setters and getter for a variable, At first, properties always point to NIL, so the setter has to be called to point the pointer to the proper object (this is done automatically for us and can be seen in compiler code), in objective-c everything is stored on the heap, so all objects are pointed to when declared
//STRONG VS WEAK: strong variables stay in the heap as long as there is something pointing to them weak variables only stay in the heap as long as there is a strong variable pointing to them
//objective-c works with "referencing counting", which means there is a counter that counts the references that arepointing to the object, when the number of references is ZERO the object is removed from the heap (no need for dealloc)
//ATOMIC VS NONATOMIC: this has to do with multithreading, NONATOMIC should always be chosen since ATOMIC can lead to problems
@property (strong, nonatomic) NSString *contents;

//We can customize getter names at declaration as shown below
@property (nonatomic, getter = isFaceUP) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

//Methods start with a dash or a plus in objective-c
//-/+ (type)name:(arguements)
//- (int)match:(Card *)card;

- (int)match:(NSArray *)otherCards;

@end

//.m files are implementation files that contain private information
