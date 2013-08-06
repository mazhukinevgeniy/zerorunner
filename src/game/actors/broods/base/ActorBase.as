package game.actors.broods.base 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.errors.AbstractClassError;
	import game.actors.view.IActorListener;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iScene:IScene;
		internal static var iListener:IActorListener;
		internal static var iInput:IKnowInput;
		
		private var helperCharacter:CellXY;
		
		public function ActorBase(hp:int, moveSpeed:int, actionSpeed:int) 
		{
			this.hp = hp;
			
			this.moveSpeed = moveSpeed;
			this.actionSpeed = actionSpeed;
			
			this.cell = new CellXY(0, 0);
			this.helperCharacter = new CellXY(0, 0);//TODO: optimize
		}
		
		final public function reset(id:int):void
		{
			this.id = id;
			
			this.isActive = true;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			this.setSpawningCell();
			
			this.onSpawned();
		}
		
		protected function setSpawningCell():void
		{
			var x:int = ActorBase.iSearcher.character.x - Metric.xDistanceActorsAllowed / 2;
			var y:int = ActorBase.iSearcher.character.y - Metric.yDistanceActorsAllowed / 2;
			
			ActorBase.iSearcher.getCharacterCell(this.helperCharacter); 
			
			do 
			{
				this.cell.setValue(x + Metric.xDistanceActorsAllowed * Math.random(),
								   y + Metric.yDistanceActorsAllowed * Math.random());
			}
			while (Metric.distance(this.helperCharacter, this.cell) < 6 || ActorBase.iSearcher.findObjectByCell(this.x, this.y) != null);
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