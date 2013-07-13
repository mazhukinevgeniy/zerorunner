package game.actors.storage 
{
	import chaotic.core.IUpdateDispatcher;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class ActorBase 
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iGrinder:IGrinder;
		internal static var iScene:IScene;
		
		
		internal var type:int;
		internal var id:int;
		
		internal var speed:int;
		internal var movingCooldown:int;
		
		internal var actionSpeed:int;
		internal var actingCooldown:int;
		
		internal var cell:CellXY;
		
		internal var active:Boolean;
		
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
			if (this.actingCooldown > 0)
				this.actingCooldown--;
			else
				this.onCanAct();
			
			if (this.movingCooldown > 0)
				this.movingCooldown--;
			else
				this.onCanMove();
		}
		
		protected function onCanAct():void
		{
			
		}
		
		protected function onCanMove():void
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
		final protected function get flow():IUpdateDispatcher
		{
			return ActorBase.iFlow;
		}
	}

}