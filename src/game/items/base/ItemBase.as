package game.items.base 
{
	import game.core.metric.ICoordinated;
	import game.items.base.cores.ActivityCore;
	import game.items.base.cores.CollisionCore;
	import game.items.base.cores.ContraptionCore;
	import game.items.base.cores.ElectricityCore;
	import game.items.base.cores.ExistenceCore;
	import starling.display.DisplayObject;
	
	public class ItemBase
	{
		protected var _contraption:ContraptionCore;
		protected var _electricity:ElectricityCore;
		protected var _existence:ExistenceCore;
		protected var _collider:CollisionCore;
		protected var _activity:ActivityCore;
		
		
		
		protected var actors:IActors;
		protected var scene:IScene;
		protected var config:GameConfig;
		
		private var actorTracker:IActorTracker;
		
		private var view:ItemViewBase;
		
		/**
		 * Don't call super until the ... //TODO: until what?
		 */
		public function ItemBase(cell:ICoordinated, view:ItemViewBase) 
		{
			
			this.view = view;
			
			this.scene = foundations.scene;
			this.actors = foundations.actors;
			this.config = foundations.database.config;
			
			this.actorTracker = foundations.actorsTracker;
			
			//TODO: set all cores
		}
		
		public function act():void
		{
			
		}
		
		
		
		
		final public function get contraption():ContraptionCore { return this._contraption; }
		final public function get electricity():ElectricityCore { return this._electricity; }
		final public function get existence():ExistenceCore { return this._existence; }
		final public function get collider():CollisionCore { return this._collider; }
		final public function get actor():ActivityCore { return this._activity; }
		
		
		/**
		 * for the external use
		 */
		
		final public function getView():DisplayObject
		{
			return this.view;
		}
	}

}