package model.items 
{
	import model.interfaces.IPuppets;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import model.utils.normalize;
	
	use namespace items_internal;
	
	public class PuppetBase implements ICoordinated
	{
		internal var _master:MasterBase;
		
		private var _x:int, _y:int;
		
		private var _occupation:int;
		
		private var framesOccupated:int;
		private var framesUntilOccupationEnds:int;
		
		private var _moveInProgress:DCellXY;
		
		private var items:Items;
		
		/* Used to avoid repeatable object creation. */
		private var dcHelper:DCellXY;
		
		public function PuppetBase(master:MasterBase, cell:ICoordinated) 
		{
			this._master = master;
			
			this.items = master.items;
			
			this.dcHelper = new DCellXY(0, 0);
			this._moveInProgress = new DCellXY(0, 0);
			
			this._x = cell.x;
			this._y = cell.y;
			
			if (this.isPassive)
				this.items.addPassiveItem(this);
			else
				this.items.addActiveItem(this);
		}
		
		public function isFree():Boolean
		{
			return this._occupation == Game.OCCUPATION_FREE;
		}
		
		final internal function tickPassed():void
		{
			if (this._occupation == Game.OCCUPATION_FREE)
			{
				
			}
			else if (this._occupation == Game.OCCUPATION_MOVING)
			{
				this.framesOccupated++;
				if (this.framesOccupated == this.framesUntilOccupationEnds)
				{
					this._occupation = Game.OCCUPATION_FREE;
					this.framesOccupated = this.framesUntilOccupationEnds = 0;
				}
			}
			else if (this._occupation == Game.OCCUPATION_DYING)
			{
				this.items.removeItem(this);
			}
			else if (this._occupation == Game.OCCUPATION_UNSTABLE)
			{
				this.onUnstabilized();
			}
		}
		
		
		final public function tryDestruction():void
		{
			if (this.isDestructible)
			{
				this.items.activateItem(this);
				
				this._occupation = Game.OCCUPATION_DYING;
				
				this._moveInProgress.setValue(1, 0); /* to be right-directioned */
			}
			else
			{
				this._occupation = Game.OCCUPATION_UNSTABLE;
				
				this._moveInProgress.setValue(1, 0); /* to be right-directioned */
			}
			
			//TODO: adress the issue: this thing can interrupt walking
		}
		
		
		
		/** Position and movements */
		
		final items_internal function startMovingBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			this._moveInProgress.setValue(change.x, change.y);
			
			this._x = normalize(change.x + this._x);
			this._y = normalize(change.y + this._y);
			
			this.items.addActiveItem(this);
			
			
			this._occupation = Game.OCCUPATION_MOVING;
			this.framesUntilOccupationEnds = this.movespeed * Game.FRAMES_PER_CYCLE;
			this.framesOccupated = 0;
		}
		
		
		/** END OF Position and movements */
		
		
		/** Things to override */
		
		protected function get movespeed():int { return 2; }
		protected function get isPassive():Boolean { return false; }
		protected function get isDestructible():Boolean { return true; }
		
		protected function onUnstabilized():void { }
		
		
		/** Public getstate methods, used by renderer and others */
		
		final public function get x():int { return this._x; }
		final public function get y():int { return this._y; }
		
		final public function get occupation():int { return this._occupation; }
		
		public function get type():int { throw new Error(); }
		
		final public function getProgress():Number 
		{
			return Number(this.framesOccupated) / this.framesUntilOccupationEnds;
		}
		final public function get moveInProgress():DCellXY { return this._moveInProgress; }
		
		
		
		final public function isLastFrame():Boolean
		{//TODO: remove if altsprites are no more
			return this.framesOccupated + 1 == this.framesUntilOccupationEnds;
		}
	}

}