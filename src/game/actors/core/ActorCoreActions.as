package game.actors.core 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	internal class ActorCoreActions extends ActorPuppet
	{
		
		public function ActorCoreActions() 
		{
			
		}
		
		
		final protected function getGrindedCell():CellXY
		{
			var y:int = this.storage.character.y - 20 + Math.random() * 40;
			var x:int = this.grinders.getFront(y);
			
			return new CellXY(x, y);
		}
		final protected function getRandomCell():CellXY
		{
			return new CellXY(this.storage.character.x - 5 + Math.random() * 15,
							  this.storage.character.y -8 + Math.random() * 21); // TODO: reduce hardcoding
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
		
		final protected function damageActor(item:ActorBase, damage:int):void
		{
			item.hp -= damage;
			
			if (!(item.hp > 0))
			{
				ActionBase.flow.dispatchUpdate(ActorsFeature.actorDestroyed, item);
			}
			else
			{
				item.onDamaged(damage);
			}
		}
	}

}