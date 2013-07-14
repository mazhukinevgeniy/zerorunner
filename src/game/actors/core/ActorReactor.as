package game.actors.core 
{
	/**
	 * Here are defined overridable onSomething-methods
	**/
	internal class ActorReactor 
	{
		
		public function ActorReactor() 
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