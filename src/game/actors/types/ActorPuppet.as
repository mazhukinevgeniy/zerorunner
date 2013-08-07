package game.actors.types 
{
	import chaotic.errors.AbstractClassError;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	public class ActorPuppet implements ICoordinated
	{
		protected var hp:int;
		
		protected var moveSpeed:int;
		protected var movingCooldown:int;
		
		protected var actionSpeed:int;
		protected var actingCooldown:int;
		
		protected var cell:CellXY;
		
		protected var isActive:Boolean;
		
		public function ActorPuppet() 
		{
			
		}
		
		
		final public function get x():int
		{
			return this.cell.x;
		}
		final public function get y():int
		{
			return this.cell.y;
		}
		
		final public function get active():Boolean
		{
			return this.isActive;
		}
		
		final public function get health():int
		{
			return this.hp;
		}
		
		/*********************
		** What you can suffer
		*********************/
		
		final public function applyDamage(damage:int):void
		{
			this.hp -= damage;
			
			if (this.hp > 0)
			{
				this.onDamaged(damage);
			}
			else
			{
				this.applyDestruction();
			}
		}
		
		final public function applyDestruction():void
		{
			if (this.isActive)
			{
				ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, item.id);
				
				this.onDestroyed();
			}
		}
		
		/****************
		**** Overridables
		****************/
		
		
		/** Called in the end of reset. */
		protected function onSpawned():void;
		
		/** Called in the begging of act(). */
		protected function onActing():void;
		
		/** Called if action cooldown expired. */
		protected function onCanAct():void;
		
		/** Called if moving cooldown expired. */
		protected function onCanMove():void;
		
		/** Called if moved succesfully */
		protected function onMoved(change:DCellXY, delay:int):void;
		
		/** Called if can not move */
		protected function onBlocked(change:DCellXY):void;
		
		/** Called if damaged and survived that damage. */
		protected function onDamaged(damage:int):void;
		
		/** Called if actor is destroyed by something. */
		protected function onDestroyed():void;
	}

}