package game.actors.types.base 
{
	import game.actors.ActorsFeature;
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
				
				this.cell.applyChanges(change);
				ActorBase.iFlow.dispatchUpdate(ActorsFeature.moveActor, this, change, this.movingCooldown + 1);
				
				this.onMoved(change, this.moveSpeed);
			}
			else
				this.onBlocked(change);
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
			this.movingCooldown = 2 * this.moveSpeed * multiplier;
			
			var jChange:DCellXY = new DCellXY(change.x * multiplier, change.y * multiplier);//TODO: do not allocate
			
			var unluckyGuy:ActorBase = ActorBase.iSearcher.findObjectByCell(this.x + jChange.x, this.y + jChange.y);
			if (unluckyGuy)
			{
				this.destroyActor(unluckyGuy);
			}
			
			this.cell.applyChanges(jChange);
			ActorBase.iFlow.dispatchUpdate(ActorsFeature.moveActor, this, jChange, this.movingCooldown + 1);
			
			ActorBase.iListener.actorJumped(this.id, jChange, this.movingCooldown + 1); //TODO: ensure that moveNormally is overridable
			
			this.onMoved(jChange, this.movingCooldown);
		}
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.iScene.getSceneCell(item.x, item.y) == SceneFeature.FALL)
			{
				this.destroyActor(item);
			}
		}
		
		final protected function damageActor(item:ActorBase, damage:int):void
		{
			if (this.actingCooldown < 0)
			{
				item.hp -= damage;
				
				if (item.hp > 0)
				{
					item.onDamaged(damage);
				}
				else
				{
					this.destroyActor(item);
				}
				
				this.actingCooldown = this.actionSpeed;
			}
			else this.actingCooldown--;
		}
		
		private function destroyActor(item:ActorBase):void
		{
			if (item.isActive)
			{
				ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, item.id);
				
				item.onDestroyed();
			}
		}
		
		/**
		 * Called in the end of reset.
		 */
		protected function onSpawned():void
		{ 
			
		}
		
		
		/**
		 * Called in the begging of act().
		 */
		protected function onActing():void
		{ 
			
		}
		/**
		 * Called if action cooldown expired.
		 */
		protected function onCanAct():void
		{
			
		}
		/**
		 * Called if moving cooldown expired.
		 */
		protected function onCanMove():void
		{
			
		}
		/**
		 * Called if moved succesfully
		 */
		protected function onMoved(change:DCellXY, delay:int):void
		{
			
		}
		/**
		 * Called if can not move
		 */
		protected function onBlocked(change:DCellXY):void
		{
			
		}
		
		/**
		 * Called if damaged and survived that damage.
		**/
		protected function onDamaged(damage:int):void
		{
			
		}
		
		/**
		 * Called if actor is destroyed by something.
		 */
		protected function onDestroyed():void
		{
			
		}
	}

}