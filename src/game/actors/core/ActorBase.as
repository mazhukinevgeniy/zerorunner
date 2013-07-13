package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iGrinder:IGrinder;
		internal static var iScene:IScene;
		
		
		public function ActorBase(configuration:XML) 
		{
			this.id = id;
			this.type = type;
			
			this.cell = cell.getCopy();
			
			this.remainingDelay = 0;
			this.data = new Object();
			
			this.active = true;
		}
		
		final public function act():void
		{
			this.onActing();
			
			if (this.actingCooldown > 0)
				this.actingCooldown--;
			else
				this.onCanAct();
			
			if (this.movingCooldown > 0)
				this.movingCooldown--;
			else
				this.onCanMove();
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
		
		final protected function dispatchUpdate(... args):void
		{
			ActorBase.iFlow.dispatchUpdate.apply(ActorBase.iFlow, args);
		}
	}

}