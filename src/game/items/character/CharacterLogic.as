package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.base.ItemBase;
	import game.items.Items;
	import game.items.items_internal;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	use namespace items_internal;
	
	internal class CharacterLogic extends ItemBase
	{
		private const SOLDERING_POWER:int = 2;//TODO: replace
		
		private var input:InputManager;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		private var items:Items;
		private var scene:IScene;
		
		public function CharacterLogic(elements:GameElements) 
		{
			this.input = elements.input;
			this.flow = elements.flow;
			this.items = elements.items;
			this.scene = elements.scene;
			
			super(elements, new Existence(this, elements));
			
			this.points = elements.pointsOfInterest;
			this.points.addPointOfInterest(Game.CHARACTER, this.existence);
			
			//TODO: initialize all cores
			
			this.flow.dispatchUpdate(Update.setCenter, this.existence);
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