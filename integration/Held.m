//
//  held.m
//  IceHockey
//
//  Created by Nico Magni on 6/29/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "Held.h"
#import "GameScene.h"

@implementation Held

+(id) heldWithGame:(GameScene*)game {
	return [[[self alloc] initWithGame:game heldResource:@"blue_held_mallets.png"] autorelease];
}

-(id) initWithGame:(GameScene*)game heldResource:(NSString*)resourceName {
	cpShape *shape = [game.spaceManager addCircleAt:cpvzero mass:100 radius:30];
	[super initWithShape:shape file:resourceName];
    
	_game = game;
    
	//Free the shape when we are released
	self.spaceManager = game.spaceManager;

    
	return self;
}


@end
