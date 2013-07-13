package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.view.IActorListener;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iGrinder:IGrinder;
		internal static var iScene:IScene;
		internal static var iListener:IActorListener;
		
		
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
		}
		
		protected function getCell():CellXY
		{
			return this.getRandomCell();
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
		
		protected function onActing():void
		{
			
		}
		
		protected function onCanAct():void
		{
			
		}
		
		protected function onCanMove():void
		{
			
		}
		
		
		
		
		
		
		
		final protected function get grinder():IGrinder
		{
			return ActorBase.iGrinder;
		}
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
		
		final protected function dispatchUpdate(... args):void
		{
			ActorBase.iFlow.dispatchUpdate.apply(ActorBase.iFlow, args);
		}
	}

}