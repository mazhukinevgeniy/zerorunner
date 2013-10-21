package game.items.base 
{
	import data.viewers.GameConfig;
	import game.core.metric.*;
	import game.GameElements;
	import game.items.IActors;
	import game.items.IActorTracker;
	import game.scene.IScene;
	import starling.display.DisplayObject;
	import utils.updates.IUpdateDispatcher;
	
	public class ItemLogicBase implements ICoordinated
	{
		protected var actors:IActors;
		protected var scene:IScene;
		protected var config:GameConfig;
		
		private var actorTracker:IActorTracker;
		
		private var view:ItemViewBase;
		
		public function ItemLogicBase(view:ItemViewBase, foundations:GameElements) 
		{
			this.view = view;
			
			this.scene = foundations.scene;
			this.actors = foundations.actors;
			this.config = foundations.database.config;
			
			this.actorTracker = foundations.actorsTracker;
			
			this.reset();
		}
		
		public function act():void
		{
			
		}
		
		protected function reset():void
		{
			//TODO: reset all cores
		}
		
		/**********
		 ** What you can suffer
		 *********/
		
		public function applyDestruction():void
		{
			this.actorTracker.removeActor(this);
			
			this.view.disappear();
		}
		
		/**
		 * for the external use
		 */
		
		final public function getView():DisplayObject
		{
			return this.view;
		}
	}

}