
//  Created by Devine Lu Linvega on 2015-11-09.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SpriteKit
import Foundation

class Blocker : Event
{
	init(x:Int,y:Int,id:Int, orientation:Orientation = Orientation.l)
	{
		super.init(x: x, y: y)
		
		updateSprite("blocker.\(id).png")
		sprite.color = UIColor.blueColor()
		
		if orientation == Orientation.r { sprite.xScale = -1.0 }
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