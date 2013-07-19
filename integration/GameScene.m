//
//  GameScene.m
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "GameScene.h"
#import "Math.h"
#import "WinScene.h"

@implementation GameScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init] )) {

        self.isTouchEnabled = YES;
        // init physics
        _winSize = [[CCDirector sharedDirector] winSize];
        redScore = 0;
        blueScore = 0;
        _redMouseBody = cpBodyNew(INFINITY, INFINITY);
        _blueMouseBody= cpBodyNew(INFINITY, INFINITY);
        
        _blueScoreLabel = [[CCLabelTTF labelWithString:@"00"
                                   dimensions:CGSizeMake(50, 50) alignment:UITextAlignmentCenter
                                     fontName:@"Arial" fontSize:30.0] retain];
        _blueScoreLabel.position = ccp((_winSize.width/2) + 30,_winSize.height-47);
        _blueScoreLabel.color = ccc3(200, 6, 28);
        [self addChild:_blueScoreLabel z:2];

        _redScoreLabel = [[CCLabelTTF labelWithString:@"00"
                                            dimensions:CGSizeMake(50, 50) alignment:UITextAlignmentCenter
                                              fontName:@"Arial" fontSize:30.0] retain];
        _redScoreLabel.position = ccp((_winSize.width/2) - 30,_winSize.height-47);
        _redScoreLabel.color = ccc3(200, 6, 28);
        [self addChild:_redScoreLabel z:1];
        
        _isPaused = false;
        

		[self initPhysics];
        
    }
    return self;
}

-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"BEgan");
    CGSize size = [[CCDirector sharedDirector] winSize];

    NSSet *allTouches = [event allTouches];
    if(_isPaused){
        return;
    }
    switch ([allTouches count]) {
        case 1: { //Single touch
            
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            CGPoint oldLoc =[self convertTouchToNodeSpace: touch];
            if(oldLoc.x > (size.width / 2) + CENTEROFFSET){
                
                _blueMouseBody->p = oldLoc;

            }else if(oldLoc.x < (size.width / 2) - CENTEROFFSET){
                
                _redMouseBody->p = oldLoc;
                
            }
            
            
        }break;
        case 2: { //Double Touch
            UITouch *t1 = [[allTouches allObjects] objectAtIndex:0];
            UITouch *t2 = [[allTouches allObjects] objectAtIndex:1];
            CGPoint p1=[self convertTouchToNodeSpace: t1];
            CGPoint p2=[self convertTouchToNodeSpace: t2];
            if(p1.x > (size.width / 2) + CENTEROFFSET && p2.x < (size.width / 2) - CENTEROFFSET){
                _redMouseBody->p = p2;
                _blueMouseBody->p = p1;
            }else if(p1.x < (size.width / 2) - CENTEROFFSET && p2.x > (size.width / 2) + CENTEROFFSET){
                _redMouseBody->p = p1;
                _blueMouseBody->p = p2;
                
            }else if(p1.x < (size.width / 2) - CENTEROFFSET && p2.x < (size.width / 2) - CENTEROFFSET){
                _redMouseBody->p = p1.x >= p2.x ? p2:p1;
            }else if(p1.x > (size.width / 2) + CENTEROFFSET && p2.x > (size.width / 2) + CENTEROFFSET){
                _blueMouseBody->p = p1.x >= p2.x ? p2:p1;
            }
//            redMouseJoint = cpPivotJointNew2(_redMouseBody, _redHeldMallets.body, cpvzero, cpvzero);
//            redMouseJoint->maxForce = 1000000.0f;
//            redMouseJoint->errorBias = cpfpow(1.0f - 0.37f, 60.0f);
//            cpSpaceAddConstraint(self.spaceManager.space, redMouseJoint);
//            blueMouseJoint = cpPivotJointNew2(_blueMouseBody, _blueHeldMallets.body, cpvzero, cpvzero);
//            blueMouseJoint->maxForce = 1000000.0f;
//            blueMouseJoint->errorBias = cpfpow(1.0f - 0.37f, 60.0f);
//            cpSpaceAddConstraint(self.spaceManager.space, blueMouseJoint);
            
        } break;
        default:
            break;
    }

    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"MOVE");

    CGSize size = [[CCDirector sharedDirector] winSize];
    NSLog(@"MOVE");
    NSSet *allTouches = [event allTouches];
    if(_isPaused){
        return;
    }
    switch ([allTouches count]) {
        case 1: { //Single touch
            
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            CGPoint oldLoc =[self convertTouchToNodeSpace: touch];
            if(oldLoc.x > (size.width / 2) + CENTEROFFSET){
                _blueMouseBody->p = oldLoc;
            }else if(oldLoc.x < (size.width / 2) - CENTEROFFSET){
                _redMouseBody->p = oldLoc;
            }
            
            
        }break;
        case 2: { //Double Touch
            UITouch *t1 = [[allTouches allObjects] objectAtIndex:0];
            UITouch *t2 = [[allTouches allObjects] objectAtIndex:1];
            CGPoint p1=[self convertTouchToNodeSpace: t1];
            CGPoint p2=[self convertTouchToNodeSpace: t2];
            if(p1.x > (size.width / 2) + CENTEROFFSET && p2.x < (size.width / 2) - CENTEROFFSET){
                _redMouseBody->p = p2;
                _blueMouseBody->p = p1;
            }else if(p1.x < (size.width / 2) - CENTEROFFSET && p2.x > (size.width / 2) + CENTEROFFSET){
                _redMouseBody->p = p1;
                _blueMouseBody->p = p2;
                
            }else if(p1.x < (size.width / 2) - CENTEROFFSET && p2.x < (size.width / 2) - CENTEROFFSET){
                _redMouseBody->p = p1.x >= p2.x ? p2:p1;
            }else if(p1.x > (size.width / 2) + CENTEROFFSET && p2.x > (size.width / 2) + CENTEROFFSET){
                _blueMouseBody->p = p1.x >= p2.x ? p1:p2;
            }
            
        } break;
        default:
            break;
    }

}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
        NSLog(@"End");
        cpBodyResetForces(_redHeldMallets.body);
            cpBodyResetForces(_blueHeldMallets.body);
            cpBodySetVel(_redHeldMallets.body, ccp(0, 0));
            cpBodySetVel(_blueHeldMallets.body, ccp(0, 0));
    cpBodySetAngVel(_redHeldMallets.body, 0);
        cpBodySetAngVel(_blueHeldMallets.body, 0);


}

-(void)initPuckWithSprite:(cpCCSprite *)ballSprite {
    _puck = ballSprite;
    _puck.position = ccp(_winSize.width/2,_winSize.height/2);
    [self.spaceManager removeBody:_puck.body];
    cpBodySetVelLimit(_puck.body, MAXVEL);

    [self.spaceManager addBody:_puck.body];
    _puck.shape->collision_type = PUCK;
        _puck.zOrder = 2;
}

-(void)initBlueHeldMalletsWithSprite:(cpCCSprite *)ballSprite {
    _blueHeldMallets = ballSprite;
    [self.spaceManager removeBody:_blueHeldMallets.body];
  //  cpBodySetMass(_blueHeldMallets.body,STATIC_MASS);
    [self.spaceManager addBody:_blueHeldMallets.body];
    _blueHeldMallets.position = ccp(_winSize.width - 40,_winSize.height/2);
    _blueHeldMallets.shape->collision_type = HELD_MALLET;
    _blueHeldMallets.zOrder = 2;
    _blueMouseBody->p = _blueHeldMallets.position;

    blueMouseJoint = cpPivotJointNew2(_blueMouseBody, _blueHeldMallets.body, cpvzero, cpvzero);
    
    blueMouseJoint->maxForce = 1000000.0f;
    blueMouseJoint->errorBias = cpfpow(1.0f - 0.37f, 60.0f);
    cpSpaceAddConstraint(self.spaceManager.space, blueMouseJoint);
}

-(void)initRedHeldMalletsWithSprite:(cpCCSprite*)ballSprite {
    _redHeldMallets = ballSprite;
    [self.spaceManager removeBody:_redHeldMallets.body];
//    cpBodySetMass(_redHeldMallets.body,STATIC_MASS);
    [self.spaceManager addBody:_redHeldMallets.body];
    
    _redHeldMallets.position = ccp(40,_winSize.height/2);
    _redHeldMallets.shape->collision_type = HELD_MALLET;
        _redHeldMallets.zOrder = 2;
    _redMouseBody->p = _redHeldMallets.position;
    redMouseJoint = cpPivotJointNew2(_redMouseBody, _redHeldMallets.body, cpvzero, cpvzero);
    redMouseJoint->maxForce = 1000000.0f;
    redMouseJoint->errorBias = cpfpow(1.0f - 0.37f, 60.0f);
    cpSpaceAddConstraint(self.spaceManager.space, redMouseJoint);


}



-(void)initBoardWithSprite:(cpCCSprite*)ballSprite {
    _board = ballSprite;
    [self.spaceManager removeBody:_board.body];
    cpBodySetMass(_board.body,STATIC_MASS);
    
    [self.spaceManager addBody:_board.body];
    
    _board.position = ccp(_winSize.width/2,_winSize.height/2);
    _board.shape->collision_type = BOARD;
    _board.zOrder = 0;
}

-(void)resetRoundForPlayer:(int)player{
    CGPoint initailPosition;
    if(player == BLUEPLAYER){
        initailPosition = ccp(_winSize.width/2 + INITIALOFFSET,_winSize.height/2);
    }else{
        initailPosition = ccp(_winSize.width/2 - INITIALOFFSET,_winSize.height/2);
    }
    cpBodyResetForces(_puck.body);
    _puck.body->v = cpvzero; _puck.body->w = 0.0f;
    _puck.position = initailPosition;
    _blueHeldMallets.position = ccp(_winSize.width - 40,_winSize.height/2);
    _redHeldMallets.position = ccp(40,_winSize.height/2);
    _blueMouseBody->p = _blueHeldMallets.position;
    _redMouseBody->p = _redHeldMallets.position;

}

-(void) addNewSpriteWithName:(NSString*)name {

    cpCCSprite *ballSprite;
    ballSprite = [cpCCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", name] bodyName:name spaceManager:self.spaceManager];
    
        if([name isEqualToString:@"puck"]){
            [self initPuckWithSprite:ballSprite];
        }else if ([name isEqualToString:@"blue_held_mallets"]){
            [self initBlueHeldMalletsWithSprite:ballSprite];
        }else if ([name isEqualToString:@"red_held_mallets"]){
            [self initRedHeldMalletsWithSprite:ballSprite];
        }else{
            [self initBoardWithSprite:ballSprite];
        }
        [self addChild:ballSprite];
}

-(void) initPhysics
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.spaceManager = [[SpaceManagerCocos2d alloc] init];
    [[[CCDirector sharedDirector] scheduler] scheduleUpdateForTarget:self priority:1 paused:NO];
    
//    self.spaceManager.steps = 3;

    [self.spaceManager setGravity:ccp(0,0)];
    [[GCpShapeCache sharedShapeCache] addShapesWithFile:@"blue_held_mallests_body.plist"];
    [self addNewSpriteWithName:@"board"];
    [self addNewSpriteWithName:@"blue_held_mallets"];
    [self addNewSpriteWithName:@"red_held_mallets"];
    [self addNewSpriteWithName:@"puck"];
    
    cpShape *shape;
    cpBody *staticBody = cpBodyNew(INFINITY, INFINITY);
    // left
    shape = cpSegmentShapeNew(staticBody, ccp(-600,0), ccp(-600,size.height), 600.0f);
    shape->e = 1.0f; shape->u = 1.0f;
    shape->collision_type = GOAL;
    shape->data = [NSNumber numberWithInt:REDPLAYER];
    cpSpaceAddStaticShape(self.spaceManager.space, shape);
    
    // right
    shape = cpSegmentShapeNew(staticBody, ccp(size.width + 600,0), ccp(size.width + 600,size.height), 600.0f);

    shape->e = 1.0f; shape->u = 1.0f;
        shape->collision_type = GOAL;
    shape->data = [NSNumber numberWithInt:BLUEPLAYER];
    cpSpaceAddStaticShape(self.spaceManager.space, shape);
    
    [self.spaceManager addCollisionCallbackBetweenType:HELD_MALLET otherType:PUCK target:self selector:@selector(handleCollisionWithCircle:arbiter:space:) moments:COLLISION_PRESOLVE, nil];
    [self.spaceManager addCollisionCallbackBetweenType:GOAL otherType:PUCK target:self selector:@selector(handleCollisionWithShape:arbiter:space:) moments:COLLISION_PRESOLVE, nil];
//    [self addChild:[self.spaceManager createDebugLayer]];

    [self.spaceManager start];
    
}

- (void) update:(ccTime)delta{

//    cpVect vel = ccp(_puck.body->v.x, _puck.body->v.y );
//    if(vel.x > FLT_MIN && vel.y > FLT_MIN){
//        cpBodySetVel(_puck.body, ccp(vel.x -4, vel.y - 4));
//
//    }
    cpBodySetAngVel(_redHeldMallets.body, 0);
    cpBodySetAngVel(_blueHeldMallets.body, 0);
//    CGPoint directionVectRed = [self directionForceToPosition:newLocationForRed];
//    if(directionVectRed.x == 0 && directionVectRed.y == 0){
//        cpBodyResetForces(_redHeldMallets.body);
//        cpBodySetVel(_redHeldMallets.body, ccp(0, 0));
//
//        //                    _redHeldMallets.position = oldLoc;
//    }else{
//        [_redHeldMallets applyImpulse:directionVectRed];
//        
//
//    }
    

}

- (void)dealloc
{
    [self.spaceManager release];
    
	[super dealloc];
	
}

- (BOOL) handleCollisionWithCircle:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space {

    CGPoint result = cpArbiterGetNormal(arb,0);
    CP_ARBITER_GET_BODIES(arb, a, b);
    cpVect auxB = cpBodyGetVel(a);
    float velocity = sqrtf(powf(auxB.x, 2) + powf(auxB.y, 2));
//    float nomaelVel = 30000/(velocity + 1);
    
//    result = ccp(result.x * 5000, result.y* 5000);
    [_puck applyImpulse:result];

//        NSLog(@"PUCK Velocity in X = %f in Y = %f",auxB.x, auxB.y);
    return 1;
}

-(BOOL) gameIsFinised{
    return redScore == SCORETOWIN || blueScore == SCORETOWIN;
}

- (void) goalHitForPalyer:(int)player{
    //add overlay that saids goal!!
    switch (player) {
        case BLUEPLAYER:
            redScore++;
            break;
        case REDPLAYER:
            blueScore++;
            break;
    }
    [_redScoreLabel setString:[NSString stringWithFormat:@"%02d",redScore]];
    [_blueScoreLabel setString:[NSString stringWithFormat:@"%02d",blueScore]];
    
    [self resetRoundForPlayer:player];
    if([self gameIsFinised]){
        //GAME FINISHED
        int winnner;
        if(redScore == SCORETOWIN){
            winnner = REDPLAYER;
        }else{
            winnner = BLUEPLAYER;
        }
        CCScene *winScene = [[WinScene alloc] initWithPlayer:winnner];
        [[CCDirector sharedDirector] pushScene:winScene];
    }
}

void
postStepRemove(cpSpace *space, cpShape *shape,id self)
{
    
    [self goalHitForPalyer:[shape->data intValue]];
}

- (BOOL) handleCollisionWithShape:(CollisionMoment)moment arbiter:(cpArbiter*)arb space:(cpSpace*)space{
    if(cpArbiterGetDepth(arb, 0) <= -13){
         CP_ARBITER_GET_SHAPES(arb, a, b);
        
        cpSpaceAddPostStepCallback(space, (cpPostStepFunc)postStepRemove,a, self);
        
    }
    return NO;
}

@end
