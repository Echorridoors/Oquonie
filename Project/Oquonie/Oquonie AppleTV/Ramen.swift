
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SpriteKit
import Foundation

class Ramen : Wizard
{
	var isKnown:Bool = false
	var isWizard:Bool = false
	var characterSprite:SKSpriteNode!
	
	init(x:Int,y:Int,spell:Personas! = nil, isWizard:Bool = false)
	{
		super.init(x: x, y: y,spell:spell)
		
		characterSprite = SKSpriteNode(texture: textureWithName("event.ramen.1.png"), color: UIColor.redColor(), size: sprite.size)
		characterSprite.position = sprite_position
		addChild(characterSprite)
		
		self.isWizard = isWizard
		updateSprite("event.ramen.absent")
	}
	
	override func onRoomEnter()
	{
		updatePresence()
		updateDialog()
	}
	
	func updatePresence()
	{
		if isKnown == true {
		}
		else{
		}
	}
	
	override func bump()
	{
		
	}
	
	override func collide()
	{
		if isKnown == false {
			let action_fade = SKAction.fadeAlphaTo(0, duration: 1)
			characterSprite.runAction(action_fade)
			isKnown = true
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}