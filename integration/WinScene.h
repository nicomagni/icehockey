//
//  WinScene.h
//  IceHockey
//
//  Created by Nico Magni on 6/25/13.
//  Copyright (c) 2013 Jorge Lorenzon. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface WinScene : CCLayer
- (void)starButtonTapped:(id)sender;
-(id) initWithPlayer:(int)player;
@end
CCLabelTTF *_label;
