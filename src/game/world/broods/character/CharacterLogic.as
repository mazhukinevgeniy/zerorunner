package game.world.broods.character 
{
	import game.IGame;
	import game.utils.GameFoundations;
	import game.utils.input.IKnowInput;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.ConfigKit;
	import utils.templates.UpdateGameBase;
	
	internal class CharacterLogic extends ItemLogicBase
	{		
		private const HP:int = 100;
		private const SOLDERING_POWER:int = 2;
		
		private var input:IKnowInput;
		
		public function CharacterLogic(foundations:GameFoundations) 
		{
			super(new CharacterView(foundations), foundations);
			
			this.input = foundations.input;
		}
		
		override protected function getConfig():ConfigKit
		{
			return new ConfigKit(this.HP, 1, 0);
		}
		
		override protected function getSpawningCell():CellXY
		{
			return Metric.getTmpCell(Game.SECTOR_WIDTH, Game.SECTOR_WIDTH * (1 + (this.game).getMapWidth()) - 1);
		}
		
		override protected function onSpawned():void
		{
			this.flow.dispatchUpdate(Update.setCenter, this);
			this.flow.dispatchUpdate(Update.setHeroHP, this.HP);
		}
		
		override protected function onMoved(change:DCellXY, delay:int):void
		{
			this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
		}
		
		override protected function onDestroyed():void
		{
			this.flow.dispatchUpdate(Update.gameOver);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround();
		}
		
		
		override protected function onCanMove():void
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			while (action.x != 0 || action.y != 0)
			{
				if (this.world.getSceneCell(this.x + action.x, this.y + action.y) != Game.FALL)
				{
					this.move(action);
					
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
		
		override protected function onBlocked(change:DCellXY):void
		{
			var gx:int = this.x + change.x;
			var gy:int = this.y + change.y;
			
			var actor:ItemLogicBase;
			
			this.world.findObjectByCell(gx, gy).applyPush();
			
			actor = this.world.findObjectByCell(gx, gy);
			if (!actor)
			{
				this.move(change);
			}
			else
			{
				actor.offerSoldering(this, this.SOLDERING_POWER);
			}
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.flow.dispatchUpdate(Update.heroDamaged, damage);
		}
	}

}