package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.SceneFeature;
	import game.ZeroRunner;
	
	internal class Character extends ActorBase
	{
		private static const HP:int = 100;
		private static const MOVE_SPEED:int = 1;
		private static const ACTION_SPEED:int = 1000;
		
		public function Character() 
		{
			super(Character.HP, Character.MOVE_SPEED, Character.ACTION_SPEED);
		}
		
		override protected function setSpawningCell():void
		{
			var c:CellXY = ActorsFeature.SPAWN_CELL;
			this.giveCell().setValue(c.x, c.y);
		}
		
		override protected function onSpawned(id:int):void
		{
			this.forceUpdate(ActorsFeature.setCenter, this.giveCell());
			this.forceUpdate(ActorsFeature.setHeroHP, this.health);
			
			this.listener.actorSpawned(id, this.giveCell(), ActorsFeature.CHARACTER);
		}
		
		override protected function onMoved(change:DCellXY, delay:int):void
		{
			this.forceUpdate(ActorsFeature.moveCenter, change, delay + 1);
			
			this.statistic.heroMoved(change);
		}
		
		override protected function onDestroyed():void
		{
			this.forceUpdate(ZeroRunner.gameOver);
			
			this.forceActive(true);
		}
		
		override protected function onActing():void
		{
			this.isOnTheGround(this);
		}
		
		
		override protected function onCanMove():void
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			while (action.x != 0 || action.y != 0)
			{
				if (this.scene.getSceneCell(this.x + action.x, this.y + action.y) != SceneFeature.FALL)
				{
					this.tryMove(action);
					
					return;
				}
				else if (this.scene.getSceneCell(this.x + 2 * action.x, this.y + 2 * action.y) != SceneFeature.FALL)
				{
					this.jump(action, 2);
					
					return;
				}
				
				action = tmp.pop();
			}
		}
		
		override protected function onBlocked(change:DCellXY):void
		{
			// TODO: implement pushing here or as an action (or somehow else)
			//this.kick(item, this.searcher.findObjectByCell(item.getCell().applyChanges(change)), change);
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.forceUpdate(ActorsFeature.heroDamaged, damage);
		}
	}

}