package game.world.items.utils 
{
	import data.viewers.GameConfig;
	import game.core.metric.*;
	import game.GameElements;
	import game.world.IActors;
	import game.world.IActorTracker;
	import game.world.IScene;
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
			this.config = foundations.config;
			
			this.actorTracker = foundations.actorsTracker;
			
			this.reset();
		}
		
		public function act():void
		{
			
		}
		
		protected function reset():void
		{
			var cell:CellXY = this.getSpawningCell();
			this._x = cell.x;
			this._y = cell.y;
			
			this.actorTracker.addActor(this);
			
			this.view.standOn(cell);
		}
		
		protected function getSpawningCell():CellXY
		{
			const width:int = this.config.width;
			
			var cell:CellXY = Metric.getTmpCell(Game.BORDER_WIDTH + Math.random() * width, 
												Game.BORDER_WIDTH + Math.random() * width);
			
			for (; this.actors.findObjectByCell(cell.x, cell.y); )
				cell.setValue(Game.BORDER_WIDTH + Math.random() * width, Game.BORDER_WIDTH + Math.random() * width);
			
			return cell;
		}
		
		/**
		 * Position
		 */
		
		private var _x:int;
		private var _y:int;
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
		
		protected function move(change:DCellXY, delay:int):void
		{
			if (!this.actors.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this._x += change.x;
				this._y += change.y;
				
				this.actorTracker.moveActor(this, change);
				
				this.view.move(this, change, delay + 1);
			}
			else
				throw new Error();
		}
		
		/**
		 * Position END
		 */
		
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