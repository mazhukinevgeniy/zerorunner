package game.world.broods 
{
	import game.IGame;
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.utils.metric.DCellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.world.IActorTracker;
	import game.world.ISearcher;
	import starling.display.DisplayObject;
	import utils.updates.IUpdateDispatcher;
	
	public class ItemLogicBase implements ICoordinated
	{
		protected var world:ISearcher;
		protected var game:IGame;
		
		
		private var view:ItemViewBase;
		
		private var cooldown:int;
		
		
		public function ItemLogicBase(view:ItemViewBase, foundations:GameFoundations) 
		{
			this.view = view;
			
			this.world = foundations.world;
			this.game = foundations.game;
			
			this.actors = foundations.actors;
			
			this.reset();
		}
		
		/**
		 * Position
		 */
		
		private var actors:IActorTracker;
		
		private var _x:int;
		private var _y:int;
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
		
		final protected function move(change:DCellXY, delay:int):void
		{
			if (!this.world.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this.cooldown = delay;
				
				this._x += change.x;
				this._y += change.y;
				
				this.actors.moveActor(this, change);
				
				this.view.move(this, change, this.cooldown + 1);
			}
			else
				throw new Error();
		}
		
		/**
		 * Position END
		 */
		
		final public function getView():DisplayObject
		{
			return this.view;
		}
		
		final public function act():void
		{
			this.cooldown--;
			
			this.onActing();
		}
		
		
		
		private function reset():void
		{
			var cell:CellXY = this.getSpawningCell();
			this._x = cell.x;
			this._y = cell.y;
			
			this.onSpawned();
			
			this.actors.addActor(this);
			
			this.view.standOn(cell);
		}
		
		/********
		 ** SETUP
		 *******/
		
		protected function getSpawningCell():CellXY
		{
			var width:int = (this.game).getMapWidth() * Game.SECTOR_WIDTH;
			var cell:CellXY = Metric.getTmpCell(Game.SECTOR_WIDTH + Math.random() * width, Game.SECTOR_WIDTH + Math.random() * width);
			
			for (; this.world.findObjectByCell(cell.x, cell.y); )
				cell.setValue(Game.SECTOR_WIDTH + Math.random() * width, Game.SECTOR_WIDTH + Math.random() * width);
			
			return cell;
		}
		
		/*********
		 ** CHECKS
		 ********/
		
		final protected function isOnTheGround():void
		{
			if (this.world.getSceneCell(this.x, this.y) == Game.FALL)
			{
				this.applyDestruction();
			}
		}
		
		
		/**********
		 ** What you can suffer
		 *********/
		
		final public function applyDestruction():void
		{
			this.actors.removeActor(this);
			
			this.view.disappear();
			
			this.onDestroyed();
		}
		
		
		
		/****************
		**** Overridables
		****************/
		
		
		/** Called in the end of reset. */
		protected function onSpawned():void { }
		
		/** Called on act(). */
		protected function onActing():void { }
		
		/** Called if actor is destroyed by something. */
		protected function onDestroyed():void 
		{ 
			this.reset();
		}
	}

}