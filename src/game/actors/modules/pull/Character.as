package game.actors.modules.pull 
{
	import game.actors.ActorsFeature;
	import game.actors.core.ActorBase;
	import game.metric.DCellXY;
	
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
			
			this.updateFlow.dispatchUpdate(ActorsFeature.setCenter, this.cell);
		}
		
		override protected function onMoved(change:DCellXY):void
		{
			this.forceUpdate(ActorsFeature.moveCenter, change, this.speed);
		}
		
		override protected function onDestroyed():void
		{
			this.flow.dispatchUpdate(ZeroRunner.gameOver);
			
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
				if (this.landscape.getSceneCell(item.getCell().applyChanges(action)) != SceneFeature.FALL)
				{
					this.callMove(item, action);
					
					return;
				}
				
				action = tmp.pop();
			}
		}
		
		override protected function afterMoved(item:Puppet):void
		{
			this.flow.dispatchUpdate(InputManager.purgeClicks);
		}
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.kick(item, this.searcher.findObjectByCell(item.getCell().applyChanges(change)), change);
		}
		
		override protected function onDamaged(damage:int):void
		{
			this.dispatchUpdate(ActorsFeature.heroDamaged, damage);
		}
	}

}