package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.ActivityCore;
	import game.items.items_internal;
	import game.scene.IScene;
	
	use namespace items_internal;
	
	internal class Activity extends ActivityCore
	{
		private var item:ICoordinated;
		
		private var input:InputManager;
		private var scene:IScene;
		
		public function Activity(item:CharacterLogic, elements:GameElements) 
		{
			super();
			
			this.item = item;
			
			this.input = elements.input;
			this.scene = elements.scene;
		}
		
		
		override items_internal function act():void
		{
			if (this.input.isSpacePressed)
			{
				this.input.getInputCopy();
				
				//this.cooldown = 10;
				//TODO: todo
			}
			else
			{
				var pos:ICoordinated = this.item;
				
				var tmp:Vector.<DCellXY> = this.input.getInputCopy();
				var action:DCellXY = tmp.pop();
				
				while (action.x != 0 || action.y != 0)
				{
					var next:int = this.scene.getSceneCell(pos.x + action.x, pos.y + action.y);
					
					if (next != Game.FALL && next != Game.LAVA)
					{
						//this.existence.move(action);
						//TODO: todo
						
						break;
					}
					else
					{
						next = this.scene.getSceneCell(pos.x + 2 * action.x, pos.y + 2 * action.y);
						
						if (next != Game.FALL && next != Game.LAVA)
						{
							//(this.existence as Existence).jump(action, 2);
							//TODO: TODO
							
							break;
						}
					}
					
					
					action = tmp.pop();
				}
			}
		}
		
		/*override items_internal function move(change:DCellXY):void
		{
			var delay:int = this.MOVE_SPEED;
			
			if (!this.items.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				super.move(change);
				
				this.item.cooldown = delay;
				//TODO: something is broken, broken to the core, infection is growing, pulled until it's tore!
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
		}
		
		items_internal function jump(change:DCellXY, multiplier:int):void
		{
			var obstacles:int = 0;
			
			for (var i:int = 0; i < multiplier; i++)
				if (this.items.findObjectByCell(this.x + (i + 1) * change.x, this.y + (i + 1) * change.y))
					return;
			
			change.setValue(change.x * multiplier, change.y * multiplier);
			
			super.move(change);
			this.item.cooldown = this.MOVE_SPEED * 2 * multiplier;
			
			this.flow.dispatchUpdate(Update.moveCenter, change, this.item.cooldown + 1);
			//TODO: animate
		}*/
	}

}