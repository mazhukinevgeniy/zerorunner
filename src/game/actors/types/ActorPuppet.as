package game.actors.types 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	
	public class ActorPuppet implements ICoordinated
	{
		protected var moveSpeed:int;
		protected var movingCooldown:int;
		
		protected var actionSpeed:int;
		protected var actingCooldown:int;
		
		private var _x:int;
		private var _y:int;
		
		private var _active:Boolean;
		private var _hp:int;
		
		public function ActorPuppet() 
		{
			
		}
		
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
		
		final public function get active():Boolean { return this._active; }
		
		//final public function get hp():int { return this._hp; }
		//TODO: might delete
		
		/*********************
		** What you can suffer
		*********************/
		
		final public function applyDamage(damage:int):void
		{
			this._hp -= damage;
			
			if (this._hp > 0)
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
			if (this._active)
			{
				//this.flow.dispatchUpdate(ActorsFeature.removeActor, item.id);
				//TODO: do it correct way
				
				this.onDestroyed();
			}
		}
		
		/****************
		**** Overridables
		****************/
		
		
		/** Called in the end of reset. */
		protected function onSpawned():void { }
		
		/** Called in the begging of act(). */
		protected function onActing():void { }
		
		/** Called if action cooldown expired. */
		protected function onCanAct():void { }
		
		/** Called if moving cooldown expired. */
		protected function onCanMove():void { }
		
		/** Called if moved succesfully */
		protected function onMoved(change:DCellXY, delay:int):void { }
		
		/** Called if can not move */
		protected function onBlocked(change:DCellXY):void { }
		
		/** Called if damaged and survived that damage. */
		protected function onDamaged(damage:int):void { }
		
		/** Called if actor is destroyed by something. */
		protected function onDestroyed():void { }
	}

}