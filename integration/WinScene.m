//
//  MainScene.m
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "WinScene.h"
#import "GameScene.h"


@implementation WinScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WinScene *layer = [WinScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) initWithPlayer:(int)player
{
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        

        CCSprite * background = [CCSprite spriteWithFile:@"initial_board.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background  z:0];
        
        // Create a label for display purposes
        _label = [[CCLabelTTF labelWithString:@"Game Finished!"
                                   dimensions:CGSizeMake(320, 50) alignment:UITextAlignmentCenter
                                     fontName:@"Arial" fontSize:32.0] retain];
        _label.position = ccp(winSize.width/2,
                              winSize.height-60);
        [self addChild:_label];
        
        // Create a label for display purposes
        NSString *playerString;
        if(player == BLUEPLAYER){
            playerString = @"Blue Player";
        }else{
            playerString = @"Red Player";
        }
        _label = [[CCLabelTTF labelWithString:[NSString stringWithFormat:@"The Player %@ wins", playerString]
                                   dimensions:CGSizeMake(420, 50) alignment:UITextAlignmentCenter
                                     fontName:@"Arial" fontSize:32.0] retain];
        _label.position = ccp(winSize.width/2,
                              winSize.height-100);
        _label.color = player == BLUEPLAYER ? ccc3(47, 128, 250):ccc3(200, 6, 28);
        [self addChild:_label];
        
        // Standard method to create a button
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"boton.png" selectedImage:@"boton_pressed.png"
                                    target:self selector:@selector(restartButtonTapped:)];
        starMenuItem.position = ccp(0, 60);
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem, nil];
        starMenu.position = CGPointMake((winSize.width/2), 80);
        [self addChild:starMenu];
        
    }
    return self;
}

- (void)restartButtonTapped:(id)sender {
//    [_label setString:@"Last button: *"];
    CCScene *gameScene = [[GameScene alloc] init];
    [[CCDirector sharedDirector] pushScene:gameScene];
    
}
@end
