package game.actors.core 
{
	import game.actors.view.IActorListener;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	internal class ActorCoreActions extends ActorPuppet
	{
		
		public function ActorCoreActions() 
		{
			
		}
		
		
		final protected function getGrindedCell():CellXY
		{
			var y:int = ActorBase.iSearcher.character.y - 20 + Math.random() * 40;
			var x:int = ActorBase.iGrinder.getFront(y);
			
			return new CellXY(x, y);
		}
		final protected function getRandomCell():CellXY
		{
			return new CellXY(ActorBase.iSearcher.character.x - 5 + Math.random() * 15,
							  ActorBase.iSearcher.character.y -8 + Math.random() * 21); // TODO: reduce hardcoding
		}
		/*
		final protected function isGrinded(item:ActorBase):void
		{
			if (ActorBase.grinder.isGrinded(item.cell))
			{
				this.destroyActor(item);
			}
			
		}*/ // TODO: move to the caching code
		
		final protected function tryMove(change:DCellXY):void
		{
			if (ActorBase.iSearcher.findObjectByCell(this.cell.getCopy().applyChanges(change)) == null) // TODO: fix syntax
			{
				this.movingCooldown = this.moveSpeed;
				
				ActorBase.iCache.cleanCell(this.x, this.y);
				this.cell.applyChanges(change);
				ActorBase.iCache.putInCell(this.x, this.y, this as ActorBase);
				
				ActorBase.iListener.actorMovedNormally(this.id, change, this.moveSpeed);
				
				this.onMoved(change);
			}
			else
				this.onBlocked(change);
		}
		/*
		final protected function isOutOfBounds(item:ActorBase):void
		{
			...
		}*/ // TODO: reimplement in the cache
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.iScene.getSceneCell(item.cell) == SceneFeature.FALL)
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
				ActorBase.iCache.cleanCell(item.x, item.y);
				
				item.onDestroyed();
			}
		}
	}

}