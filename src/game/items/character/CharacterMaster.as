package game.items.character 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.items_internal;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class CharacterMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function CharacterMaster(elements:GameElements) 
		{
			
			
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			new Character(this, this.elements);
		}
		
		override items_internal function actOn(puppet:PuppetBase):void
		{
		/*	if (this.input.isSpacePressed)
			{
				this.input.getInputCopy();
				
				//this.cooldown = 10;
				//TODO: todo
			}
			else
			{				
				var tmp:Vector.<DCellXY> = this.input.getInputCopy();
				var action:DCellXY = tmp.pop();
				
				while (action.x != 0 || action.y != 0)
				{
					var next:int = this.scene.getSceneCell(this.x + action.x, this.y + action.y);
					
					if (next != Game.FALL && next != Game.LAVA)
					{
						//this.existence.move(action);
						//TODO: todo
						
						break;
					}
					else
					{
						next = this.scene.getSceneCell(this.x + 2 * action.x, this.y + 2 * action.y);
						
						if (next != Game.FALL && next != Game.LAVA)
						{
							//(this.existence as Existence).jump(action, 2);
							//TODO: TODO
							
							break;
						}
					}
					
					
					action = tmp.pop();
				}
			}*/
		}
	}

}