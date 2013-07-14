package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.view.IActorListener;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iScene:IScene;
		internal static var iListener:IActorListener;
		internal static var iCache:IActorCache;
		internal static var iInput:IKnowInput;
		
		
		public function ActorBase(hp:int, moveSpeed:int, actionSpeed:int) 
		{
			this.hp = hp;
			
			this.moveSpeed = moveSpeed;
			this.actionSpeed = actionSpeed;
		}
		
		final public function reset(id:int):void
		{
			this.id = id;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			this.cell = this.getCell();
			
			this.onSpawned();
		}
		
		protected function getCell():CellXY
		{
			return new CellXY(ActorBase.iSearcher.character.x - 5 + Math.random() * 15,
							  ActorBase.iSearcher.character.y -8 + Math.random() * 21); // TODO: reduce hardcoding
		}
		
		
		
		final public function act():void
		{
			this.onActing();
			
			if (this.actingCooldown < 0)
				this.onCanAct();
			else
				this.actingCooldown--;
			
			if (this.movingCooldown < 0)
				this.onCanMove();
			else
				this.movingCooldown--;
		}
		
		
		/**
		 * Informer access methods
		 */
		
		final protected function get scene():IScene
		{
			return ActorBase.iScene;
		}
		final protected function get searcher():ISearcher
		{
			return ActorBase.iSearcher;
		}
		final protected function get listener():IActorListener
		{
			return ActorBase.iListener;
		}
		final protected function get input():IKnowInput
		{
			return ActorBase.iInput;
		}
		
		
		/**
		 * DANGER: force methods
		 */
		
		final protected function forceActive(value:Boolean):void
		{
			this.isActive = value;
		}
		
		final protected function forceUpdate(... args):void
		{
			ActorBase.iFlow.dispatchUpdate.apply(ActorBase.iFlow, args);
		}
	}

}