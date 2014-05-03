package game.items.character 
{
	import game.GameElements;
	import game.input.InputTeller;
	import game.items.Items;
	import game.items.items_internal;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.isCellSolid;
	import game.scene.IScene;
	
	use namespace items_internal;
	
	public class CharacterMaster extends MasterBase
	{		
		private var input:InputTeller;
		private var scene:IScene;
		private var items:Items;
		
		public function CharacterMaster(elements:GameElements) 
		{
			super(elements);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.input = this.elements.inputTeller;
			this.scene = this.elements.scene;
			this.items = this.elements.items;
			
			new Character(this, this.elements, new CellXY(x, y));
		}
		
		override protected function act(puppet:PuppetBase):void
		{
			var isStanding:Boolean = (puppet.occupation == Game.OCCUPATION_FREE);
			var isFlying:Boolean = (puppet.occupation == Game.OCCUPATION_FLOATING);
			
			if (this.input.isActionRequested(Game.ACTION_FLIGHT))
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
			
			//TODO: it's currently possible to shift movemode and move at the same turn; fix that
			
			if (isStanding)
			{
				while (action.x != 0 || action.y != 0)
				{
					if (!this.items.findAnyObjectByCell(x + action.x, y + action.y))
					{
						next = this.scene.getSceneCell(x + action.x, y + action.y);
						
						if (isCellSolid(next))
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
						
						puppet.startFlyingBy(action);
						
						break;
					}
					
					action = tmp.pop();
				}
			}
			
			/* Please note: the following code works if and only if hero always moves willingly */
			
			if (puppet.occupation != Game.OCCUPATION_FLYING
			    && puppet.occupation != Game.OCCUPATION_FLOATING
				&& !isCellSolid(this.scene.getSceneCell(puppet.x, puppet.y)))
			{
				puppet.tryDestruction();
			}
		}
	}

}