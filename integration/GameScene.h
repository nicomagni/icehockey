//
//  GameScene.h
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

// Import the interfaces
#import "HelloWorldLayer.h"
#import "cpCCSprite+PhysicsEditor.h"
#import "GCpShapeCache.h"
#import "SpaceManagerCocos2d.h"
#import "cpCCSprite.h"

#import "chipmunk.h"

@interface GameScene : CCLayer
{
    CCLabelTTF *_redScoreLabel;
    CCLabelTTF *_blueScoreLabel;
    CCSprite *_background;
    cpCCSprite *_redHeldMallets;
    cpCCSprite *_blueHeldMallets;
    cpCCSprite *_puck;
    cpCCSprite *_board;

    	
    
}

@property (nonatomic) SpaceManagerCocos2d* spaceManager;
-(void) initPhysics;

- (int) handleCollisionWithShape:(cpShape*)shape1
                          shape2:(cpShape*)shape2
                      contactPts:(cpContact*)contacts
                     numContacts:(int)numContacts
                      normalCoef:(cpFloat)coef;

@end
