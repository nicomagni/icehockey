//
//  GameScene.m
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "GameScene.h"

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
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"air_hockey_board.png"];
		} else {
			background = [CCSprite spriteWithFile:@"air_hockey_board.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
        [self resizeSprite:background toWidth:size.width toHeight:size.height];
		
		// add the label as a child to this Layer
		[self addChild: background];


        _redHeldMallets = [CCSprite spriteWithFile:@"red_held_mallets.png"];
        _redHeldMallets.position = ccp(40,size.height/2);
        
        _blueHeldMallets = [CCSprite spriteWithFile:@"blue_held_mallets.png"];
        _blueHeldMallets.position = ccp(size.width - 40,size.height/2);
        
        _puck = [CCSprite spriteWithFile:@"puck.png"];
        _puck.position = ccp(size.width/2,size.height/2);
        
        [self addChild:_puck];
        [self addChild:_blueHeldMallets];
        [self addChild:_redHeldMallets];
        self.isTouchEnabled = YES;
        
    }
    return self;
}

-(void)resizeSprite:(CCSprite*)sprite toWidth:(float)width toHeight:(float)height {
    sprite.scaleX = width / sprite.contentSize.width;
    sprite.scaleY = height / sprite.contentSize.height;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"begin");
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];

    _blueHeldMallets.position = location;
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Ended");
}

@end
