//
//  MainScene.m
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "MainScene.h"
#import "GameScene.h"


@implementation MainScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init] )) {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Create a label for display purposes
        _label = [[CCLabelTTF labelWithString:@"Welcome to Air Hockey"
                                   dimensions:CGSizeMake(320, 50) alignment:UITextAlignmentCenter
                                     fontName:@"Arial" fontSize:32.0] retain];
        _label.position = ccp(winSize.width/2,
                              winSize.height-(_label.contentSize.height/2));
        [self addChild:_label];
        
        // Standard method to create a button
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"boton.png" selectedImage:@"boton_pressed.png"
                                    target:self selector:@selector(starButtonTapped:)];
        starMenuItem.position = ccp(0, 80);
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem, nil];
        starMenu.position = CGPointMake((winSize.width/2), 80);
        [self addChild:starMenu];
        
    }
    return self;
}

- (void)starButtonTapped:(id)sender {
//    [_label setString:@"Last button: *"];
    CCScene *gameScene = [[GameScene alloc] init];
    [[CCDirector sharedDirector] pushScene:gameScene];
    
}
@end
