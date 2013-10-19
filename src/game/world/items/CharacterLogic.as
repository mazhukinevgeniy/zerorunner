package game.world.items 
{
	import game.core.input.InputManager;
	import game.core.metric.*;
	import game.GameElements;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.ISolderable;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class CharacterLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 1;
		private const SOLDERING_POWER:int = 2;
		
		private var input:InputManager;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		
		private var cooldown:int;
		
		private var view:CharacterView;
		
		public function CharacterLogic(foundations:GameElements) 
		{
			this.input = foundations.input;
			this.flow = foundations.flow;
			
			this.points = foundations.pointsOfInterest;
			this.points.addPointOfInterest(Game.CHARACTER, this);
			
			super(this.view = new CharacterView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.BORDER_WIDTH, Game.BORDER_WIDTH + this.config.width - 1);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.flow.dispatchUpdate(Update.setCenter, this);
			
			this.cooldown = 0;
		}
		
		
		override public function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
		
		override public function act():void
		{
			for (var i:int = -5; i < 6; i++)
				for (var j:int = -5; j < 6; j++)
				{
					var actor:ItemLogicBase = this.actors.findObjectByCell(this.x + i, this.y + j);
					
					if (actor && 
						actor is ISolderable && 
						(actor as ISolderable).progress < 1)
						this.points.addPointOfInterest(Game.TOWER, actor);
				}
			
			if (this.cooldown > 0)
				this.cooldown--;
			else
			{
				var tmp:Vector.<DCellXY> = this.input.getInputCopy();
				var action:DCellXY = tmp.pop();
				
				while (action.x != 0 || action.y != 0)
				{
					var next:int = this.scene.getSceneCell(this.x + action.x, this.y + action.y);
					
					if (next != Game.FALL && next != Game.LAVA)
					{
						this.move(action, this.MOVE_SPEED);
						
						break;
					}
					else
					{
						next = this.scene.getSceneCell(this.x + 2 * action.x, this.y + 2 * action.y);
						
						if (next != Game.FALL && next != Game.LAVA)
						{
							this.jump(action, 2);
							
							break;
						}
					}
					
					
					action = tmp.pop();
				}
				
				this.input.discardClicks();
			}
		}
		
		override protected function move(change:DCellXY, delay:int):void
		{
			var actor:ItemLogicBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
			if (!actor)
			{
				super.move(change, delay);
				this.view.animateWalking(change, delay);
				
				this.cooldown = this.MOVE_SPEED;
				
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
			else if (actor is ISolderable)
			{
				(actor as ISolderable).applySoldering(this.SOLDERING_POWER);
				
				//TODO: animate
			}
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
			var obstacles:int = 0;
			
			for (var i:int = 0; i < multiplier; i++)
				if (this.actors.findObjectByCell(this.x + (i + 1) * change.x, this.y + (i + 1) * change.y))
					return;
			
			this.cooldown = this.MOVE_SPEED * 2 * multiplier;
			
			var jChange:DCellXY = Metric.getTmpDCell(change.x * multiplier, change.y * multiplier);
			
			super.move(jChange, this.cooldown);
			
			
			this.flow.dispatchUpdate(Update.moveCenter, jChange, this.cooldown + 1);
			this.input.discardClicks();
			//TODO: animate
		}
		
	}

}