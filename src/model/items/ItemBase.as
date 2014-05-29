package model.items 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.items.structs.ItemParams;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import utils.distance;
	import utils.getCellId;
	import utils.getDirection;
	import utils.normalize;
	
	public class ItemBase implements ICoordinated
	{
		private var _x:int, _y:int;
		
		internal var width:int;
		internal var height:int;
		
		internal var direction:int;
		
		internal var occupation:int;
		
		internal var framesOccupated:int;
		internal var framesUntilOccupationEnds:int;
		
		private var storage:ItemStorage;
		private var notifier:ItemNotifier;
		
		private var status:IStatus;
		
		public function ItemBase(params:ItemParams) 
		{
			this.storage = params.items.storage;
			this.notifier = params.items.notifier;
			
			this.status = params.binder.gameStatus;
			
			this.direction = Game.DIRECTION_RIGHT;
			
			this._x = params.x;
			this._y = params.y;
			
			this.width = params.width;
			this.height = params.height;
			
			for (var i:int = this._x; i < this._x + this.width; i++)
				for (var j:int = this._y; j < this._y + this.height; j++)
				{
					var cellId:int = getCellId(i, j);
					
					this.storage.addItem(this, cellId);
				}
			
			if (this.isActive)
				this.notifier.addActor(this);
			
			this.framesOccupated = this.framesUntilOccupationEnds = 
				1; //so we don't divide by zero when calculating progress
		}
		
		internal function gameFrame():void
		{
			if (this.occupation == Game.OCCUPATION_FREE)
			{
				
			}
			else if (this.occupation == Game.OCCUPATION_MOVING)
			{
				this.framesOccupated++;
				if (this.framesOccupated == this.framesUntilOccupationEnds)
				{
					this.occupation = Game.OCCUPATION_FREE;
				}
			}
			else if (this.occupation == Game.OCCUPATION_UNSTABLE)
			{
				
			}
			
			if (this.occupation == Game.OCCUPATION_FREE &&
			    distance(this, 
				         this.status.getLocationOfHero()) < Game.ACTION_RADIUS)
			{
				this.act();
			}
		}
		
		internal function tryDestruction():void
		{
			if (this.isDestructible)
			{
				if (this.occupation == Game.OCCUPATION_MOVING)
				{
					//keep the progress
				}
				
				this.occupation = Game.OCCUPATION_UNSTABLE;
				
				this.onUnstabilized();
			}
		}
		
		
		
		/** Position and movements */
		
		final protected function startMovingBy(change:DCellXY):void
		{
			this.storage.removeItem(getCellId(this._x, this._y));
			this.direction = getDirection(change);
			
			this._x = normalize(change.x + this._x);
			this._y = normalize(change.y + this._y);
			
			this.storage.addItem(this, getCellId(this._x, this._y));
			
			this.occupation = Game.OCCUPATION_MOVING;
			this.framesUntilOccupationEnds = this.movespeed;
			this.framesOccupated = 0;
		}
		
		final protected function die():void
		{
			this.tryDestruction();
		}
		
		final public function get x():int { return this._x; }
		final public function get y():int { return this._y; }
		
		/** END OF Position and movements */
		
		
		/** Things to override */
		
		protected function get movespeed():int { return 10; }
		protected function get isDestructible():Boolean { return true; }
		protected function get isActive():Boolean { return false; }
		
		protected function act():void {	}
		
		protected function onUnstabilized():void 
		{ 
			this.storage.removeItem(getCellId(this._x, this._y));
			
			if (this.isActive)
				this.notifier.removeActor(this);
		}
		
		
		public function get type():int { throw new Error(); }
	}

}