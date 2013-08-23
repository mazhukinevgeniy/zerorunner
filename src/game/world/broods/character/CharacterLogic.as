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
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	
	public class CharacterLogic extends ItemLogicBase
	{
		private const MOVE_SPEED:int = 1;
		private const SOLDERING_POWER:int = 2;
		
		private var input:IKnowInput;
		private var flow:IUpdateDispatcher;
		
		public function CharacterLogic(foundations:GameFoundations) 
		{
			this.input = foundations.input;
			this.flow = foundations.flow;
			
			super(new CharacterView(foundations), foundations);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.SECTOR_WIDTH, Game.SECTOR_WIDTH * (1 + (this.game).getMapWidth()) - 1);
		}
		
		override protected function reset():void
		{
			super.reset();
			
			this.flow.dispatchUpdate(Update.setCenter, this);
		}
		
		protected function onMoved(change:DCellXY, delay:int):void
		{
			this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
			this.flow.dispatchUpdate(Update.discardClicks);
		}
		
		override public function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameOver);
		}
		
		override public function act():void
		{
			
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{/*
			this.movingCooldown = 2 * this.moveSpeed * multiplier;
			
			var jChange:DCellXY = Metric.getTmpDCell(change.x * multiplier, change.y * multiplier);
			
			var unluckyGuy:ItemLogicBase;
			
			for (var i:int = 0; i < multiplier; i++)
			{
				unluckyGuy = this.world.findObjectByCell(this._x + (i + 1) * change.x, this._y + (i + 1) * change.y);
				
				if (unluckyGuy)
					unluckyGuy.applyDestruction();
			}
			
			this._x += jChange.x;
			this._y += jChange.y;
			
			this.actors.moveActor(this, jChange);
			
			this.view.jump(this, jChange, this.movingCooldown + 1);
			
			this.onMoved(jChange, this.movingCooldown);*/
		}
		
		 protected function onCanMove():void
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
		
		 protected function onBlocked(change:DCellXY):void
		{
			var gx:int = this.x + change.x;
			var gy:int = this.y + change.y;
			
			var actor:ItemLogicBase = this.world.findObjectByCell(gx, gy);
			if (actor && actor is IPushable)
			{
				actor.applyDestruction();
				this.move(change, this.MOVE_SPEED);
			}
			else if (actor && actor is ISolderable)
			{
				(actor as ISolderable).applySoldering(this.SOLDERING_POWER);
			}
		}
	}

}