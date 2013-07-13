package game.actors.core 
{
	import game.metric.DCellXY;
	
	internal class ActorCoreActions extends ActorPuppet
	{
		
		public function ActorCoreActions() 
		{
			
		}
		
		
		/*
		final protected function isGrinded(item:ActorBase):void
		{
			if (ActorBase.grinder.isGrinded(item.cell))
			{
				this.destroyActor(item);
			}
			
		}*/ // TODO: move to the caching code
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.scene.getSceneCell(item.cell) == SceneFeature.FALL)
			{
				this.destroyActor(item);
			}
		}
		
		final protected function tryMove(change:DCellXY):void
		{
			if (ActorBase.iSearcher.findObjectByCell(this.cell.getCopy().applyChanges(change)) == null) // TODO: fix syntax
			{
				this.movingCooldown = this.moveSpeed;
				var id:int = item.id;
				
				if (id == ActorsFeature.PROTAGONIST_ID)
					ActionBase.flow.dispatchUpdate(ActorsFeature.moveCenter, change, item.speed + 1);
				
				ActionBase.flow.dispatchUpdate(ActorsFeature.actorMoved, item, change, item.remainingDelay + 1);
				
				this.afterMoved(item);
			}
			else
				this.onBlocked(change);
		}
		/*
		final protected function isOutOfBounds(item:ActorBase):void
		{
			...
		}*/ // TODO: reimplement in the cache
		
		final protected function damageActor(item:Puppet, damage:int):void
		{
			item.hp -= damage;
			
			ActionBase.flow.dispatchUpdate(ActorsFeature.actorDamaged, item, damage);
			
			if (!(item.hp > 0))
			{
				ActionBase.flow.dispatchUpdate(ActorsFeature.actorDestroyed, item);
			}
		}
		
		protected function onDamaged(damage:int):void
		{
			
		}
	}

}