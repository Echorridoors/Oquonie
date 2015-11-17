
//  Created by Devine Lu Linvega on 2015-11-17.
//  Copyright © 2015 XXIIVV. All rights reserved.

import Foundation

class Dialogs
{
	init()
	{
	}
	
	func castSpell(spell:String) -> Array<String>
	{
		return ["\(Letter.foe)","\(Letter.unlocked)",spell]
	}
	
	func requiresPillar() -> Array<String>
	{
		return ["\(Letter.foe)","\(Letter.locked)","\(Letter.pillar)"]
	}
	
	func requiresPersona(persona:String) -> Array<String>
	{
		return ["\(Letter.foe)","\(Letter.locked)",persona]
	}
	
	func alreadyIsPersona(spell:String) -> Array<String>
	{
		return ["\(Letter.friend)","\(Letter.correct)",spell]
	}
	
	func transform(persona:String) -> Array<String>
	{
		return ["\(Letter.friend)","\(Letter.outside)",persona]
	}
}
