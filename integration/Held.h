//
//  held.h
//  IceHockey
//
//  Created by Nico Magni on 6/29/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "SpaceManagerCocos2d.h"
#import "GameScene.h"

@class GameScene;

@interface Held : cpCCSprite
{
	GameScene *_game;
}
+(id) heldWithGame:(GameScene*)game;
-(id) initWithGame:(GameScene*)game;
@end

