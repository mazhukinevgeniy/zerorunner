package game.items.character 
{
	import data.viewers.GameConfig;
	import game.core.input.InputManager;
	import game.core.metric.DCellXY;
	import game.GameElements;
	import game.items.Items;
	import game.items.items_internal;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.scene.IScene;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class CharacterMaster extends MasterBase
	{
		private var elements:GameElements;
		
		private var input:InputManager;
		private var scene:IScene;
		private var items:Items;
		
		public function CharacterMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			this.input = elements.input;
			this.scene = elements.scene;
			this.items = elements.items;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			new Character(this, this.elements);
		}
		
		override items_internal function actOn(puppet:PuppetBase):void
		{
			if (puppet.free)
			{
				if (this.input.isSpacePressed)
				{
					this.input.getInputCopy();
					//TODO: that's too hacky, use other way
					
					puppet.tryShocking();
				}
				else
				{				
					var tmp:Vector.<DCellXY> = this.input.getInputCopy();
					var action:DCellXY = tmp.pop();
					
					var x:int = puppet.x;
					var y:int = puppet.y;
					
					while (action.x != 0 || action.y != 0)
					{
						if (!this.items.findObjectByCell(x + action.x, y + action.y))
						{
							var next:int = this.scene.getSceneCell(x + action.x, y + action.y);
							
							if (next != Game.FALL && next != Game.LAVA)
							{
								//this.existence.move(action);
								//TODO: todo
								
								break;
							}
							else
							{
								next = this.scene.getSceneCell(x + 2 * action.x, y + 2 * action.y);
								
								if (next != Game.FALL && next != Game.LAVA)
								{
									//(this.existence as Existence).jump(action, 2);
									//TODO: TODO
									
									break;
								}
							}	
						}
						
						action = tmp.pop();
					}
				}
			}
		}
	}

}