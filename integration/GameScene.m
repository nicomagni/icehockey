//
//  GameScene.m
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "GameScene.h"
#import "Held.h"

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
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		
//		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//			background = [CCSprite spriteWithFile:@"air_hockey_board.png"];
//		} else {
//			background = [CCSprite spriteWithFile:@"air_hockey_board.png"];
//		}
//		background.position = ccp(size.width/2, size.height/2);
//        [self resizeSprite:background toWidth:size.width toHeight:size.height];
		
		// add the label as a child to this Layer
//		[self addChild: background];        


        self.isTouchEnabled = YES;
        // init physics
		[self initPhysics];
        
    }
    return self;
}

-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGSize size = [[CCDirector sharedDirector] winSize];

    NSSet *allTouches = [event allTouches];
    switch ([allTouches count]) {
        case 1: { //Single touch
            
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            CGPoint oldLoc =[self convertTouchToNodeSpace: touch];
            if(oldLoc.x > size.width / 2){
                _blueHeldMallets.position = oldLoc;
            }else{
                _redHeldMallets.position = oldLoc;
            }
            
        }break;
        case 2: { //Double Touch
            UITouch *t1 = [[allTouches allObjects] objectAtIndex:0];
            UITouch *t2 = [[allTouches allObjects] objectAtIndex:1];
            CGPoint p1=[self convertTouchToNodeSpace: t1];
            CGPoint p2=[self convertTouchToNodeSpace: t2];
            if(p1.x > size.width / 2){
                _blueHeldMallets.position = p1;
                _redHeldMallets.position = p2;
            }else{
                _blueHeldMallets.position = p2;
                _redHeldMallets.position = p1;
            }
        } break;
        default:
            break;
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(void) addNewSprite: (float)x y:(float)y name:(NSString*)name {
    CGSize size = [[CCDirector sharedDirector] winSize];
    cpCCSprite *ballSprite;
    
    ballSprite = [cpCCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", name] bodyName:name spaceManager:self.spaceManager];
    [self addChild:ballSprite];

        if([name isEqualToString:@"puck"]){
            _puck = ballSprite;
            _puck.position = ccp(size.width/2,size.height/2);
            _puck.shape->collision_type = 1;
        }else if ([name isEqualToString:@"blue_held_mallets"]){
            _blueHeldMallets = ballSprite;
            _blueHeldMallets.position = ccp(size.width - 40,size.height/2);
            _blueHeldMallets.shape->collision_type = 0;
        }else if ([name isEqualToString:@"red_held_mallets"]){
            _redHeldMallets = ballSprite;
            _redHeldMallets.position = ccp(40,size.height/2);
            _redHeldMallets.shape->collision_type = 0;
        }else{
            _board = ballSprite;
            _board.position = ccp(size.width/2,size.height/2);
            _board.zOrder = -1;
        }
    
}

-(void) initPhysics
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    self.spaceManager = [[SpaceManagerCocos2d alloc] init];
    
    [self.spaceManager addWindowContainmentWithFriction:1.0 elasticity:1000 inset:cpvzero];

    [self.spaceManager setGravity:ccp(0,0)];
    [[GCpShapeCache sharedShapeCache] addShapesWithFile:@"blue_held_mallests_body.plist"];
    [self addNewSprite:200 y:200 name:@"blue_held_mallets"];
    [self addNewSprite:200 y:200 name:@"red_held_mallets"];
    [self addNewSprite:200 y:200 name:@"puck"];
    [self addNewSprite:200 y:200 name:@"board"];
    
    
        [self.spaceManager addCollisionCallbackBetweenType:1 otherType:0 target:self selector:@selector(handleCollisionWithShape:shape2:contactPts:numContacts:normalCoef:) moments:COLLISION_BEGIN, nil];
        [self addChild:[self.spaceManager createDebugLayer]];

    [self.spaceManager start];

}

- (void)dealloc
{
    [self.spaceManager release];
    
	[super dealloc];
	
}

- (int) handleCollisionWithShape:(cpShape*)shape1
                          shape2:(cpShape*)shape2
                      contactPts:(cpContact*)contacts
                     numContacts:(int)numContacts
                      normalCoef:(cpFloat)coef
{    
    NSLog(@"collision!");
    return 1;
}

@end
