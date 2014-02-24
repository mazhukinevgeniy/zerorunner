package game.items.character 
{
	import data.viewers.GameConfig;
	import game.forceFields.IForceField;
	import game.GameElements;
	import game.input.IKnowInput;
	import game.items.Items;
	import game.items.items_internal;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.metric.DCellXY;
	import game.scene.IScene;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class CharacterMaster extends MasterBase
	{
		private var elements:GameElements;
		
		private var input:IKnowInput;
		private var scene:IScene;
		private var items:Items;
		private var force:IForceField;
		
		public function CharacterMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
		}
		
		update function restore(config:GameConfig):void
		{
			this.input = this.elements.input;
			this.scene = this.elements.scene;
			this.items = this.elements.items;
			this.force = this.elements.forceFields;
			
			new Character(this, this.elements);
		}
		
		override protected function act(puppet:PuppetBase):void
		{
			var isStanding:Boolean = (puppet.occupation == Game.OCCUPATION_FREE);
			var isFlying:Boolean = (puppet.occupation == Game.OCCUPATION_FLOATING);
			
			if (this.input.isSpacePressed)
			{
				if (isStanding)
				{
					puppet.forceAirborne();
					
					isStanding = false; 
					isFlying = true;
				}
				else if (isFlying)
				{
					puppet.forceStanding();
					
					isStanding = true; 
					isFlying = false;
				}
			}
			
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			var x:int = puppet.x;
			var y:int = puppet.y;
			
			var next:int;
			
			
			if (isStanding)
			{
				while (action.x != 0 || action.y != 0)
				{
					if (!this.items.findAnyObjectByCell(x + action.x, y + action.y))
					{
						next = this.scene.getSceneCell(x + action.x, y + action.y);
						
						if (this.force.isCellCovered(x + action.x, y + action.y) || (next != Game.SCENE_FALL && next != Game.SCENE_LAVA))
						{
							puppet.startMovingBy(action);
							
							break;
						}
					}
					
					action = tmp.pop();
				}
			}
			else if (isFlying)
			{
				while (action.x != 0 || action.y != 0)
				{
					if (!this.items.findAnyObjectByCell(x + action.x, y + action.y))
					{
						next = this.scene.getSceneCell(x + action.x, y + action.y);
						
						if (this.force.isCellCovered(x + action.x, y + action.y) || (next != Game.SCENE_LAVA))
						{
							puppet.startFlyingBy(action);
							
							break;
						}
					}
					
					action = tmp.pop();
				}
			}
		}
	}

}