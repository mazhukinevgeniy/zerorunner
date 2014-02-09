package game.items 
{
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import starling.display.DisplayObject;
	
	use namespace items_internal;
	
	public class PuppetBase implements ICoordinated
	{
		internal var _master:MasterBase;
		
		private var _x:int, _y:int;
		
		private var _occupation:int;
		
		private var ticksOccupated:int;
		private var ticksUntilOccupationEnds:int;
		
		private var _moveInProgress:DCellXY;
		
		private var items:Items;
		
		/* Used to avoid repeatable object creation. */
		private var dcHelper:DCellXY;
		
		public function PuppetBase(master:MasterBase, elements:GameElements, cell:CellXY = null) 
		{
			this._master = master;
			this.items = elements.items;
			
			this.dcHelper = new DCellXY(0, 0);
			this._moveInProgress = new DCellXY(0, 0);
			
			if (cell == null)
			{
				const width:int = Game.MAP_WIDTH;
				
				cell = new CellXY(Math.random() * width, 
								  Math.random() * width);
				
				while (this.items.findAnyObjectByCell(cell.x, cell.y))
					cell.setValue(Math.random() * width, 
								  Math.random() * width);
			}
			
			this._x = cell.x;
			this._y = cell.y;
			
			if (this.isPassive)
				this.items.addPassiveItem(this);
			else
				this.items.addActiveItem(this);
			
			this.onSpawned();
		}
		
		final internal function tickPassed():void
		{
			if (this._occupation == Game.OCCUPATION_FREE)
			{
				
			}
			else if (this._occupation == Game.OCCUPATION_FLOATING)
			{
				if (!this.canFly)
					this._occupation = Game.OCCUPATION_FALLING;
			}
			else if (this._occupation == Game.OCCUPATION_MOVING)
			{
				this.ticksOccupated++;
				if (this.ticksOccupated == this.ticksUntilOccupationEnds)
				{
					this._occupation = Game.OCCUPATION_FREE;
					this.ticksOccupated = this.ticksUntilOccupationEnds = 0;
				}
			}
			else if (this._occupation == Game.OCCUPATION_FLYING)
			{
				this.ticksOccupated++;
				if (this.ticksOccupated == this.ticksUntilOccupationEnds)
				{
					this._occupation = Game.OCCUPATION_FLOATING;
					this.ticksOccupated = this.ticksUntilOccupationEnds = 0;
				}
			}
			else if (this._occupation == Game.OCCUPATION_DYING)
			{
				this.items.removeItem(this);
				
				this.onDied();
			}
			else if (this._occupation == Game.OCCUPATION_FALLING)
			{
				//TODO: take damage or something
				
				this._occupation = Game.OCCUPATION_FREE;
			}
		}
		
		
		final items_internal function get master():MasterBase { return this._master; }
		
		final items_internal function forceDestruction():void
		{
			this._occupation = Game.OCCUPATION_DYING;
		}
		
		
		
		/** Position and movements */
		
		final items_internal function forceMoveBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			this._moveInProgress.setValue(change.x, change.y);
			
			this._x = (change.x + this._x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			this._y = (change.y + this._y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			this.items.addActiveItem(this);
			
			
			this._occupation = Game.OCCUPATION_MOVING;
			this.ticksUntilOccupationEnds = this.movespeed;
			this.ticksOccupated = 0;
			
			this.onMoved(change);
		}
		
		final items_internal function forceFlyingBy(change:DCellXY):void
		{
			this.items.removeItem(this);
			this._moveInProgress.setValue(change.x, change.y);
			
			this._x = (change.x + this._x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			this._y = (change.y + this._y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			this.items.addActiveItem(this);
			
			
			this._occupation = Game.OCCUPATION_FLYING;
			this.ticksUntilOccupationEnds = this.flyingSpeed;
			this.ticksOccupated = 0;
			
			this.onMoved(change);
		}
		
		
		
		final items_internal function forceJumpBy(change:DCellXY, length:int):void
		{
			this.dcHelper.setValue(change.x * length, change.y * length);
			
			this.forceMoveBy(this.dcHelper);
			
			//this.item.cooldown = this.MOVE_SPEED * 2 * multiplier;
			//TODO: handle onMoved conflict (can't apply custom delay)
			//TODO: think if jumps must be slower than walking
			//TODO: delete if possible after all
		}
		
		final items_internal function forceAirborne():void
		{
			if (this._occupation != Game.OCCUPATION_FREE)
				throw new Error("conflict here, try to avoid the case (forceAirborne failed)");
			
			this._occupation = Game.OCCUPATION_FLOATING;
		}
		
		final items_internal function forceStanding():void
		{
			if (this._occupation != Game.OCCUPATION_FLOATING)
				throw new Error("conflict here, try to avoid the case (forceStanding failed)");
			
			this._occupation = Game.OCCUPATION_FREE;
		}
		
		/** END OF Position and movements */
		
		
		/** Things to override */
		
		protected function get movespeed():int { return 2; }
		protected function get flyingSpeed():int { return 1; }
		protected function get canFly():Boolean { return false; }
		protected function get isPassive():Boolean { return false; }
		
		protected function onSpawned():void { }
		protected function onMoved(change:DCellXY):void { }
		protected function onDied():void { }
		
		
		/** Public getstate methods, used by renderer and others */
		
		final public function get x():int { return this._x; }
		final public function get y():int { return this._y; }
		
		final public function get occupation():int { return this._occupation; }
		
		public function get type():int { throw new Error(); }
		
		final public function getProgress(frame:int):Number 
		{
			return Number(Number(this.ticksOccupated + Number(frame / Game.FRAMES_PER_CYCLE)) / this.ticksUntilOccupationEnds);
		}
		final public function get moveInProgress():DCellXY { return this._moveInProgress; }
		
		
		
		final public function isLastFrame(flashFrame:int):Boolean
		{//TODO: check if it should be here
			return (this.ticksOccupated + 1 == this.ticksUntilOccupationEnds) && (flashFrame == Game.FRAMES_PER_CYCLE - 1);
		}
	}

}