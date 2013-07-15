package game.actors.core 
{
	import game.actors.view.IActorListener;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	internal class ActorCoreActions extends ActorPuppet
	{
		
		public function ActorCoreActions() 
		{
			
		}
		
		
		final protected function tryMove(change:DCellXY):void
		{
			if (!ActorBase.iSearcher.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this.movingCooldown = this.moveSpeed;
				
				ActorBase.iSearcher.putInCell(this.x, this.y);
				this.cell.applyChanges(change);
				ActorBase.iSearcher.putInCell(this.x, this.y, this as ActorBase);
				
				ActorBase.iListener.actorMovedNormally(this.id, change, this.moveSpeed + 1);
				
				this.onMoved(change, this.moveSpeed);
			}
			else
				this.onBlocked(change);
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
			this.movingCooldown = this.moveSpeed * multiplier;
			
			var jChange:DCellXY = new DCellXY(change.x * multiplier, change.y * multiplier);//TODO: do not allocate
			
			var unluckyGuy:ActorBase = ActorBase.iSearcher.findObjectByCell(this.x + jChange.x, this.y + jChange.y);
			if (unluckyGuy)
			{
				this.destroyActor(unluckyGuy);
				ActorBase.iListener.actorDeadlyDamaged(unluckyGuy.id);
			}
			
			
			ActorBase.iSearcher.putInCell(this.x, this.y);
			this.cell.setValue(this.x + jChange.x, this.y + jChange.y);
			ActorBase.iSearcher.putInCell(this.x, this.y, this as ActorBase);
			
			ActorBase.iListener.actorJumped(this.id, jChange, this.movingCooldown + 1);
			
			this.onMoved(jChange, this.movingCooldown + 1);
		}
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.iScene.getSceneCell(item.x, item.y) == SceneFeature.FALL)
			{
				ActorBase.iListener.actorFallen(item.id);
				
				this.destroyActor(item);
			}
		}
		
		final protected function damageActor(item:ActorBase, damage:int):void
		{
			item.hp -= damage;
			
			if (item.hp > 0)
			{
				item.onDamaged(damage);
			}
			else
			{
				this.destroyActor(item);
				
				ActorBase.iListener.actorDeadlyDamaged(item.id);
			}
		}
		
		private function destroyActor(item:ActorBase):void
		{
			if (item.isActive)
			{
				item.isActive = false;
				ActorBase.iSearcher.putInCell(item.x, item.y);
				
				item.onDestroyed();
			}
		}
	}

}