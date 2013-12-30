//
//  xxiivvViewController.m
//  Oquonie
//
//  Created by Devine Lu Linvega on 2013-07-08.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvWorld.h"
#import "xxiivvEvents.h"
#import "worldLobby.h"
#import "worldNecomedre.h"

@implementation xxiivvViewController (world)

- (void) worldStart
{
	worldNode = [NSMutableArray arrayWithObjects:@"",nil];
	int myCount = 0;
	while ( myCount < 10 )	{ myCount++; worldNode[myCount] = [NSArray arrayWithObjects: @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", nil];	}
	
	// Event : @"1|event|test|7|l"
	// Block : @"6|block|5"
	// Warp  : @"11|warp|2|0,-1"
	
	// 0 - 10
	
	[self createWorldLobby];
	
	// 11 - 20
	
	[self createWorldNecomedre];
		
	
	
}

- (NSString*) tileParser :(NSString*)tileString :(int)index {
		
	NSArray* array = [tileString componentsSeparatedByString: @"|"];
	if( [array count] < (index+1) && index > 0 ){
		return 0;
	}
	NSString* value = [array objectAtIndex: index];
	
	return value;
}

- (void) roomStart
{
	NSLog(@">  ROOM | Load         * Node.%d - %@", userLocation, worldNode[userLocation][21]);
	[self cleanParallax];
	[self roomCleanSprites];
	[self roomCleanNotifications];
	[self roomGenerateTiles];
	[self roomGenerateBlockers];
	[self roomGenerateEvents];
	[self roomGenerateNotifications];
	[self roomGenerateAudioTrack];
	
}

-(void)roomGenerateTiles {
	self.floor00.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][4]:0]] ];
	self.floor1e.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][8]:0]] ];
	self.floore1.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][0]:0]] ];
	self.floor10.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][1]:0]] ];
	self.floor01.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][5]:0]] ];
	self.floor0e.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][3]:0]] ];
	self.floore0.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][7]:0]] ];
	self.floor11.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][2]:0]] ];
	self.flooree.image = [UIImage imageNamed:[NSString stringWithFormat:@"tile.%@.png",[self tileParser:worldNode[userLocation][6]:0]] ];
	
	self.wall1l.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.r.png",[self tileParser:worldNode[userLocation][9]:0]] ];
	self.wall2l.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.r.png",[self tileParser:worldNode[userLocation][10]:0]] ];
	self.wall3l.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.r.png",[self tileParser:worldNode[userLocation][11]:0]] ];
	self.wall1r.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.l.png",[self tileParser:worldNode[userLocation][14]:0]] ];
	self.wall2r.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.l.png",[self tileParser:worldNode[userLocation][13]:0]] ];
	self.wall3r.image = [UIImage imageNamed:[NSString stringWithFormat:@"wall.%@.l.png",[self tileParser:worldNode[userLocation][12]:0]] ];
	
	self.step1l.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.l.png",[self tileParser:worldNode[userLocation][15]:0]] ];
	self.step2l.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.l.png",[self tileParser:worldNode[userLocation][16]:0]] ];
	self.step3l.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.l.png",[self tileParser:worldNode[userLocation][17]:0]] ];
	self.step1r.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.r.png",[self tileParser:worldNode[userLocation][18]:0]] ];
	self.step2r.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.r.png",[self tileParser:worldNode[userLocation][19]:0]] ];
	self.step3r.image = [UIImage imageNamed:[NSString stringWithFormat:@"step.%@.r.png",[self tileParser:worldNode[userLocation][20]:0]] ];
}


-(void)roomGenerateBlockers {
	int tileId = 0;
	for (NSString *tile in worldNode[userLocation]) {
		if( [[self tileParser:tile :1] isEqualToString:@"block"] ){
			NSLog(@">  ROOM | Blockers     | Generate: #%@ x:%d y:%d", [self tileParser:tile :2], [self flattenTileId:tileId :@"x"], [self flattenTileId:tileId :@"y"] );
			UIImageView *newView = [[UIImageView alloc] initWithFrame:[self tileLocation:4 :[self flattenTileId:tileId :@"x"] :[self flattenTileId:tileId :@"y"]]];
			newView.tag = 10;
			newView.image = [UIImage imageNamed:[NSString stringWithFormat:@"blocker.%@.png",[self tileParser:tile :2]]];
			[self.spritesContainer addSubview:newView];
		}
		tileId += 1;
	}
}

-(void)roomGenerateEvents {
	int tileId = 0;
	for (NSString *tile in worldNode[userLocation]) {
		if( [[self tileParser:tile :1] isEqualToString:@"event"] ){
			NSLog(@">  ROOM | Blockers     | Generate: #%@ x:%d y:%d", [self tileParser:tile :2], [self flattenTileId:tileId :@"x"], [self flattenTileId:tileId :@"y"] );
			UIImageView *newView = [[UIImageView alloc] initWithFrame:[self tileLocation:4 :[self flattenTileId:tileId :@"x"] :[self flattenTileId:tileId :@"y"]]];
			newView.tag = 20;
			newView.image = [UIImage imageNamed:[NSString stringWithFormat:@"event.%@.%@.png",[self tileParser:tile :3],[self tileParser:tile :4]]];
			[self.spritesContainer addSubview:newView];
		}
		tileId += 1;
	}
}

-(void)roomGenerateNotifications {
	NSLog(@">  ROOM | Notification | Display");
	int tileId = -1; // ...
	for (NSString *tile in worldNode[userLocation]) {
		tileId += 1;
		// Skip if not an event
		if( ![[self tileParser:tile :1] isEqualToString:@"event"] ){ continue; }
		// Skip if has no notification
		NSString *eventSelector = [NSString stringWithFormat:@"event_%@:",[self tileParser:tile :2]];
		int hasNotification = [self performSelector:NSSelectorFromString(eventSelector) withObject:@"postNotification"];
		if(hasNotification<1){ continue; }
		// Notification
		NSLog(@"> NOTIF | Notification for event %@", [self tileParser:tile :2]); // TODOX
		UIImageView *newView = [[UIImageView alloc] initWithFrame:[self tileLocation:4 :[self flattenTileId:tileId :@"x"] :[self flattenTileId:tileId :@"y"]]];
		newView.tag = 30;
		newView.image = [UIImage imageNamed:[NSString stringWithFormat:@"fx.notification.1.png"]];
		[self.spritesContainer addSubview:newView];
		
	}
}

-(void)roomGenerateAudioTrack {
	if(![userAudioTrack isEqualToString:worldNode[userLocation][23] ]){
		NSLog(@">  ROOM | Audio:%@",worldNode[userLocation][23]);
		userAudioTrack = worldNode[userLocation][23];
	}
}

- (void) roomCleanSprites
{
	NSLog(@">  ROOM | Blockers     | Clean");
	for (UIView *subview in [self.spritesContainer subviews]) {
		// Remove Blockers
		if(subview.tag == 10){
			[subview removeFromSuperview];
		}
		// Remove Events
		if(subview.tag == 20){
			[subview removeFromSuperview];
		}
	}
}

- (void) roomCleanNotifications
{
	NSLog(@">  ROOM | Notification | Clean ");
	for (UIView *subview in [self.spritesContainer subviews]) {
		// Remove Notification
		if(subview.tag == 30){
			[subview removeFromSuperview];
		}
	}
}

- (void) cleanParallax
{
	self.parallaxFront.alpha = 0;
	self.parallaxBack.alpha = 0;
	self.parallaxFront.frame = CGRectOffset(parallaxFrontOrigin, (userPositionX*-1+userPositionY)*3, (userPositionX+userPositionY)*-3);
	self.parallaxBack.frame = CGRectOffset(parallaxFrontOrigin, (userPositionX*-1+userPositionY)*1.5, (userPositionX+userPositionY)*-1.5);
}


@end