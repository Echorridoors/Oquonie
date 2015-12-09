
//  Created by Devine Lu Linvega on 2015-11-29.
//  Copyright © 2015 XXIIVV. All rights reserved.

import SpriteKit
import Foundation

var touch_origin:CGPoint!
var touch_hold:CGPoint!
var touchTimer:NSTimer!
var isHolding:Bool = false

extension MainViewController
{	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player == nil { return }
		
		if touchTimer != nil { touchTimer.invalidate() }
		
		if let touch = touches.first {
			let point = touch.locationInView(self.view)
			touch_origin = point
		}
		super.touchesBegan(touches, withEvent:event)
		
		touchTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "touchesHeld", userInfo: nil, repeats: true)
	}
	
	override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player == nil { return }
		
		if let touch = touches.first {
			let point = touch.locationInView(self.view)
			touch_hold = point
		}
		super.touchesMoved(touches, withEvent:event)
	}
	
	func touchesHeld()
	{
		if player == nil { return }
		
		isHolding = true
		if distanceBetweenTwoPoints(touch_hold, b: touch_origin) > self.view.frame.width/10 {
			if touch_hold.y < touch_origin.y && touch_hold.x > touch_origin.x { player.move(1, y: 0) }
			if touch_hold.y < touch_origin.y && touch_hold.x < touch_origin.x { player.move(0, y: 1) }
			if touch_hold.y > touch_origin.y && touch_hold.x > touch_origin.x { player.move(0, y: -1) }
			if touch_hold.y > touch_origin.y && touch_hold.x < touch_origin.x { player.move(-1, y: 0) }
		}
	}
	
	override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
	{
		if player == nil { return }
		
		if isHolding == true {
			touchTimer.invalidate()
			isHolding = false
			return
		}
		if let touch = touches.first {
			let point = touch.locationInView(self.view)
			
			if distanceBetweenTwoPoints(point, b: touch_origin) > self.view.frame.width/10 {
				if point.y < touch_origin.y && point.x > touch_origin.x { player.move(1, y: 0) }
				if point.y < touch_origin.y && point.x < touch_origin.x { player.move(0, y: 1) }
				if point.y > touch_origin.y && point.x > touch_origin.x { player.move(0, y: -1) }
				if point.y > touch_origin.y && point.x < touch_origin.x { player.move(-1, y: 0) }
			}
			else{
				poke(point)
			}
		}
		super.touchesEnded(touches, withEvent:event)
		
		touchTimer.invalidate()
	}
	
	func poke(point:CGPoint)
	{
		if player == nil { return }
		
		if overlay.alpha > 0 {
			player.hideOverlay()
		}
		
		if dialog.isActive == true {
			dialog.hideModal()
			return
		}
		// Poke Controls
		
		if point.x < view.frame.size.width * 0.33 && point.y < view.frame.size.height * 0.33 { player.move(0, y: 1) }
		else if point.x > view.frame.size.width * 0.66 && point.y < view.frame.size.height * 0.33 { player.move(1, y: 0) }
		else if point.x < view.frame.size.width * 0.33 && point.y > view.frame.size.height * 0.66 { player.move(-1, y: 0) }
		else if point.x > view.frame.size.width * 0.66 && point.y > view.frame.size.height * 0.66 { player.move(0, y: -1) }
		
		audio.play(.interface, name: "click")
	}
	
	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
	{
		if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
			return .AllButUpsideDown
		} else {
			return .All
		}
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
	}
	
	override func prefersStatusBarHidden() -> Bool
	{
		return true
	}
}