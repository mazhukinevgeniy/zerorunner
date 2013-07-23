package game.actors.core 
{
	import chaotic.core.IUpdateDispatcher;
	import game.achievements.IActorStatistic;
	import game.actors.view.IActorListener;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ActorStorage;
		internal static var iScene:IScene;
		internal static var iStat:IActorStatistic;
		internal static var iListener:IActorListener;
		internal static var iInput:IKnowInput;
		
		
		public function ActorBase(hp:int, moveSpeed:int, actionSpeed:int) 
		{
			this.hp = hp;
			
			this.moveSpeed = moveSpeed;
			this.actionSpeed = actionSpeed;
			
			this.cell = new CellXY(0, 0);
		}
		
		final public function reset(id:int):void
		{
			this.id = id;
			
			this.isActive = true;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			this.setSpawningCell();
			
			ActorBase.iSearcher.putInCell(this.cell.x, this.cell.y, this);
			
			this.onSpawned(id);
		}
		
		protected function setSpawningCell():void
		{
			var dX:int;
			var dY:int;
			
			var x:int = ActorBase.iSearcher.character.x;
			var y:int = ActorBase.iSearcher.character.y;
			
			do 
			{
				do
				{
					dX = -Metric.xDistanceActorsAllowed + Math.random() * (2 * Metric.xDistanceActorsAllowed);
				}
				while (Math.abs(dX) < 6);
				
				do
				{
					dY = -Metric.yDistanceActorsAllowed + Math.random() * (2 * Metric.yDistanceActorsAllowed);
				}
				while (Math.abs(dY) < 6);
			}
			while (ActorBase.iSearcher.findObjectByCell(x + dX, y + dY) != null);
			
			this.cell.setValue(x + dX, y + dY);
		}
		
		
		
		final public function act():void
		{
			this.onActing();
			
			if (this.actingCooldown == 0)
				this.onCanAct();
			else
				this.actingCooldown--;
			
			if (this.movingCooldown == 0)
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
		final protected function get statistic():IActorStatistic
		{
			return ActorBase.iStat;
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