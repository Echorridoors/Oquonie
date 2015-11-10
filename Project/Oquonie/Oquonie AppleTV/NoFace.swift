
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SceneKit
import Foundation

class NoFace : Event
{
	override init(x:Int,y:Int)
	{
		super.init(x: x, y: y)
		
		updateSprite("event.noface.png")
	}
	
	override func collide()
	{
		print("Hit blocker")
		player.isMoving = false
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}