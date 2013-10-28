package game.items.character 
{
	import game.items.base.ActivityCore;
	
	internal class Activity extends ActivityCore
	{
		
		public function Activity() 
		{
			
		}
		
		
		override public function act():void
		{
			var pos:ICoordinated = this.existence;
			
			for (var i:int = -5; i < 6; i++)
				for (var j:int = -5; j < 6; j++)
				{
					var item:ItemBase = this.items.findObjectByCell(pos.x + i, pos.y + j);
					
					if (item && item.contraption && !item.contraption.finished)
						this.points.addPointOfInterest(Game.TOWER, item.existence);
				}
			
			if (this.cooldown > 0)
				this.cooldown--;
			else
			{
				if (this.input.isSpacePressed)
				{
					this.input.getInputCopy();
					
					this.cooldown = 10;
				}
				else
				{
					var tmp:Vector.<DCellXY> = this.input.getInputCopy();
					var action:DCellXY = tmp.pop();
					
					while (action.x != 0 || action.y != 0)
					{
						var next:int = this.scene.getSceneCell(pos.x + action.x, pos.y + action.y);
						
						if (next != Game.FALL && next != Game.LAVA)
						{
							this.existence.move(action);
							
							break;
						}
						else
						{
							next = this.scene.getSceneCell(pos.x + 2 * action.x, pos.y + 2 * action.y);
							
							if (next != Game.FALL && next != Game.LAVA)
							{
								(this.existence as Existence).jump(action, 2);
								
								break;
							}
						}
						
						
						action = tmp.pop();
					}
				}
			}
		}
	}

}