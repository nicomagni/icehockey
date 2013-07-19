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


//#import "chipmunk.h"

@interface GameScene : CCLayer
{
    CCLabelTTF *_redScoreLabel;
    CCLabelTTF *_blueScoreLabel;
    CCSprite *_background;
    cpCCSprite *_redHeldMallets;
    cpCCSprite *_blueHeldMallets;
    cpCCSprite *_puck;
    cpCCSprite *_board;
    CGSize _winSize;
    int blueScore;
    int redScore;
    BOOL _isPaused;

    cpBody *_redMouseBody;
    cpBody *_blueMouseBody;
    cpConstraint *redMouseJoint;
    cpConstraint *blueMouseJoint;
    
}

@property (nonatomic) SpaceManagerCocos2d* spaceManager;
-(void) initPhysics;

- (BOOL) handleCollisionWithCircle:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space;
- (BOOL) handleCollisionWithShape:(cpShape*)shape1
                          shape2:(cpShape*)shape2
                      contactPts:(cpContact*)contacts
                     numContacts:(int)numContacts
                      normalCoef:(cpFloat)coef;


@end
