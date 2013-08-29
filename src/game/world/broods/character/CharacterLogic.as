package game.world.broods.character 
{
	import game.IGame;
	import game.utils.GameFoundations;
	import game.utils.input.IKnowInput;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.Metric;
	import game.world.broods.IPushable;
	import game.world.broods.ISolderable;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	import game.world.broods.wormholes.WormholeLogic;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	
	public class CharacterLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 1; //TODO: parametrize
		private const SOLDERING_POWER:int = 2; //TODO: parametrize
		
		private var input:IKnowInput;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		
		private var cooldown:int;
		
		public function CharacterLogic(foundations:GameFoundations, points:IPointCollector) 
		{
			this.input = foundations.input;
			this.flow = foundations.flow;
			
			points.addPointOfInterest(Game.CHARACTER, this);
			
			this.points = points;
			
			super(new CharacterView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.SECTOR_WIDTH, Game.SECTOR_WIDTH * (1 + (this.game).mapWidth) - 1);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.flow.dispatchUpdate(Update.setCenter, this);
			
			this.cooldown = 0;
		}
		
		
		override public function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameOver);
		}
		
		override public function act():void
		{
			for (var i:int = -5; i < 6; i++)
				for (var j:int = -5; j < 6; j++)
				{
					var actor:ItemLogicBase = this.world.findObjectByCell(this.x + i, this.y + j);
					
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
					if (this.world.getSceneCell(this.x + action.x, this.y + action.y) != Game.FALL)
					{
						this.move(action, this.MOVE_SPEED);
						
						return;
					}
					else if (this.world.getSceneCell(this.x + 2 * action.x, this.y + 2 * action.y) != Game.FALL)
					{
						this.jump(action, 2);
						
						return;
					}
					
					action = tmp.pop();
				}
			}
		}
		
		override protected function move(change:DCellXY, delay:int):void
		{
			var actor:ItemLogicBase = this.world.findObjectByCell(this.x + change.x, this.y + change.y);
			if (!actor)
			{
				super.move(change, delay);
				
				this.cooldown = this.MOVE_SPEED;
				
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
			else if (actor is IPushable)
			{
				actor.applyDestruction();
				super.move(change, delay);
				
				this.cooldown = this.MOVE_SPEED;
				
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
			else if (actor is ISolderable)
			{
				(actor as ISolderable).applySoldering(this.SOLDERING_POWER);
				
				//TODO: animate
			}
			else if (actor is WormholeLogic)
			{
				//TODO: jump into the mystery
			}
			
			this.flow.dispatchUpdate(Update.discardClicks);
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
			var obstacles:int = 0;
			
			for (var i:int = 0; i < multiplier; i++)
				if (this.world.findObjectByCell(this.x + (i + 1) * change.x, this.y + (i + 1) * change.y))
					return;
			
			this.cooldown = this.MOVE_SPEED * 2 * multiplier;
			
			var jChange:DCellXY = Metric.getTmpDCell(change.x * multiplier, change.y * multiplier);
			
			super.move(jChange, this.cooldown);
			
			
			this.flow.dispatchUpdate(Update.moveCenter, jChange, this.cooldown + 1);
			this.flow.dispatchUpdate(Update.discardClicks);
			//TODO: animate
		}
		
	}

}