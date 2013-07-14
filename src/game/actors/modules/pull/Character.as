package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	import game.input.InputManager;
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
		
		override protected function onSpawned():void
		{
			this.forceUpdate(ActorsFeature.setCenter, this.getCell());
		}
		
		override protected function onMoved(change:DCellXY, delay:int):void
		{
			this.forceUpdate(ActorsFeature.moveCenter, change, delay); //TODO: must move center in any case... damn, it'll be easier with sprites doing this job
			this.forceUpdate(InputManager.purgeClicks);
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
				if (this.scene.getSceneCell(this.getCell().applyChanges(action)) != SceneFeature.FALL)
				{
					this.tryMove(action);
					
					return;
				}
				else
				{
					//TODO: consider jumping
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