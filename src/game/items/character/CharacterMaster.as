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
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.input = elements.input;
			this.scene = elements.scene;
			this.items = elements.items;
			
			new Character(this, this.elements);
		}
		
		override protected function act(puppet:PuppetBase):void
		{
			if (puppet.free)
			{
				const isFlying:Boolean = (puppet as Character).isFlying;
				
				if (this.input.isSpacePressed)
				{
					//TODO: add fuel-related logic
					(puppet as Character).isFlying = !isFlying;
				}
				
				
				var tmp:Vector.<DCellXY> = this.input.getInputCopy();
				var action:DCellXY = tmp.pop();
				
				var x:int = puppet.x;
				var y:int = puppet.y;
				
				while (action.x != 0 || action.y != 0)
				{
					if (!this.items.findObjectByCell(x + action.x, y + action.y))
					{
						var next:int = this.scene.getSceneCell(x + action.x, y + action.y);
						
						if (!isFlying)
						{
							if (next != Game.SCENE_FALL && next != Game.SCENE_LAVA)
							{
								puppet.forceMoveBy(action);
								
								break;
							}
						}
						else
						{
							
						}
					}
					
					action = tmp.pop();
				}
			}
		}
		
		//TODO: finalize as much as possible
	}

}