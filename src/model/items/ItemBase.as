package model.items 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.items.structs.ItemParams;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import utils.distance;
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
		
		
		private var items:Items;
		private var status:IStatus;
		
		public function ItemBase(params:ItemParams) 
		{
			this.items = params.items;
			this.status = params.binder.gameStatus;
			
			this.direction = Game.DIRECTION_RIGHT;
			
			this._x = params.x;
			this._y = params.y;
			
			this.width = params.width;
			this.height = params.height;
			
			for (var i:int = params.x + params.width - 1; i >= params.x; i--)
				for (var j:int = params.y + params.height - 1; j >= params.y; j--)
				{
					this._x = i;
					this._y = j;
					
					this.items.addItem(this);
				}
			//TODO: rewrite, not clean enough
			
			if (this.isActive)
				this.items.notifier.addActor(this);
		}
		
		internal function gameFrame(frame:int):void
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
					this.framesOccupated = this.framesUntilOccupationEnds = 0;
				}
			}
			else if (this.occupation == Game.OCCUPATION_UNSTABLE)
			{
				this.onUnstabilized();
			}
			
			if (frame == Game.FRAME_TO_ACT &&
			    this.occupation == Game.OCCUPATION_FREE &&
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
				this.items.removeItem(this);
				
				if (this.isActive)
					this.items.notifier.removeActor(this);
			}
			else
			{
				this.occupation = Game.OCCUPATION_UNSTABLE;
				
				this.direction = Game.DIRECTION_RIGHT;
			}
			
			//TODO: adress the issue: this thing can interrupt walking
		}
		
		
		
		/** Position and movements */
		
		final protected function startMovingBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			this.direction = getDirection(change);
			
			this._x = normalize(change.x + this._x);
			this._y = normalize(change.y + this._y);
			
			this.items.addItem(this);
			
			this.occupation = Game.OCCUPATION_MOVING;
			this.framesUntilOccupationEnds = this.movespeed * Game.FRAMES_PER_CYCLE;
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
		
		protected function get movespeed():int { return 2; }
		protected function get isDestructible():Boolean { return true; }
		protected function get isActive():Boolean { return false; }
		
		protected function act():void {	}
		
		protected function onUnstabilized():void { }
		
		
		public function get type():int { throw new Error(); }
	}

}