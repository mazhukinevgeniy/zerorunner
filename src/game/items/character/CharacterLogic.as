package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.ItemBase;
	import game.items.Items;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	
	internal class CharacterLogic extends ItemBase
	{
		private const SOLDERING_POWER:int = 2;//TODO: replace
		
		private var input:InputManager;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		private var scene:IScene;
		
		public function CharacterLogic(elements:GameElements) 
		{
			this.input = elements.input;
			this.flow = elements.flow;
			this.items = elements.items;
			this.scene = elements.scene;
			
			var cell:CellXY = new CellXY
					(Game.BORDER_WIDTH, 
					 Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(elements, cell);
			//TODO: override occupations
			
			this.points = elements.pointsOfInterest;
			
			this.flow.dispatchUpdate(Update.setCenter, this);
		}
		
		/*
		override internal function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}*///TODO: move to the occupation (because dying is business too)
		
		override public function act():void
		{
			if (this.input.isSpacePressed)
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