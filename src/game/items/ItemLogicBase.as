package game.items 
{
	import game.input.IKnowInput;
	import game.items.utils.ConfigKit;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.world.ISearcher;
	import starling.display.DisplayObject;
	import utils.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	
	public class ItemLogicBase implements ICoordinated
	{
		protected var world:ISearcher;
		protected var flow:IUpdateDispatcher;
		
		private var view:ItemViewBase;
		
		private var moveSpeed:int;
		private var movingCooldown:int;
		
		private var actionSpeed:int;
		private var actingCooldown:int;
		
		private var _x:int;
		private var _y:int;
		
		private var _active:Boolean;
		private var _hp:int;
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
		
		final public function get active():Boolean { return this._active; }
		
		
		public function ItemLogicBase(view:ItemViewBase) 
		{
			this.view = view;
			
			this.world = BroodmotherBase.world;
			this.flow = BroodmotherBase.flow;
		}
		
		final public function getView():DisplayObject
		{
			return this.view;
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
		
		
		
		/********
		 ** SETUP
		 *******/
		
		final public function reset():void
		{
			var config:ConfigKit = this.getConfig();
			
			this._hp = config.health;
			this.moveSpeed = config.movingSpeed;
			this.actionSpeed = config.actingSpeed;
			
			this._active = true;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			var cell:CellXY = this.getSpawningCell();
			this._x = cell.x;
			this._y = cell.y;
			
			this.onSpawned();
			
			this.flow.dispatchUpdate(ActorsFeature.addActor, this);
			
			this.view.standOn(cell);
		}
		
		protected function getSpawningCell():CellXY
		{
			var character:ICoordinated = this.world.getCenter();
			
			const MIN_DISTANCE:int = 6;
			const VARIETY:int = 5;
			
			var dX:int = (Math.random() * Metric.CELLS_IN_VISIBLE_WIDTH / 2) * ((Math.random() < 0.5) ? 1 : -1);
			var dY:int = (MIN_DISTANCE - Math.abs(dX) + Math.random() * VARIETY) * ((Math.random() < 0.5) ? 1 : -1);
			
			var cell:CellXY = Metric.getTmpCell(character.x + dX, character.y + dY);
			
			for (; this.world.findObjectByCell(cell.x, cell.y); )
			{
				dX = (Math.random() * Metric.CELLS_IN_VISIBLE_WIDTH / 2) * ((Math.random() < 0.5) ? 1 : -1);
				dY = (MIN_DISTANCE - Math.abs(dX) + Math.random() * VARIETY) * ((Math.random() < 0.5) ? 1 : -1);
				
				cell.setValue(character.x + dX, character.y + dY);
			}
			
			return cell;
		}
		
		protected function getConfig():ConfigKit
		{
			throw new AbstractClassError();
		}
		
		/*********
		 ** CHECKS
		 ********/
		
		final protected function isOnTheGround():void
		{
			if (this.world.getSceneCell(this.x, this.y) == SceneFeature.FALL)
			{
				this.applyDestruction();
			}
		}
		
		/**********
		 ** What you can suffer
		 *********/
		
		final public function applyPush():void
		{
			
			
			this.onPushed();
		}
		
		final public function applyWind(change:DCellXY):void
		{
			this.onWind(change);
		}
		
		final public function applyDamage(damage:int):void
		{
			this._hp -= damage;
			
			if (this._hp > 0)
			{
				this.onDamaged(damage);
			}
			else
			{
				this.applyDestruction();
			}
		}
		
		final public function applyDestruction():void
		{
			if (this._active)
			{
				this.flow.dispatchUpdate(ActorsFeature.removeActor, this);
				this._active = false;
				
				this.view.disappear();
				
				this.onDestroyed();
			}
		}
		
		/**********
		 ** What others can offer to you
		 *********/
		
		final public function offerSoldering(offerer:ItemLogicBase):void
		{
			
			
			this.onSoldered(offerer);
		}
		
		/********
		 * What you can do
		 *******/
		
		final protected function move(change:DCellXY):void
		{
			if (!this.world.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this.movingCooldown = this.moveSpeed;
				
				this._x += change.x;
				this._y += change.y;
				
				this.flow.dispatchUpdate(ActorsFeature.moveActor, this, change, this.movingCooldown + 1);
				
				this.view.moveNormally(this, change, this.movingCooldown + 1);
				
				this.onMoved(change, this.moveSpeed);
			}
			else
				this.onBlocked(change);
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
			this.movingCooldown = 2 * this.moveSpeed * multiplier;
			
			var jChange:DCellXY = Metric.getTmpDCell(change.x * multiplier, change.y * multiplier);
			
			var unluckyGuy:ItemLogicBase;
			
			for (var i:int = 0; i < multiplier; i++)
			{
				unluckyGuy = this.world.findObjectByCell(this._x + (i + 1) * change.x, this._y + (i + 1) * change.y);
				
				if (unluckyGuy)
					unluckyGuy.applyDestruction();
			}
			
			this._x += jChange.x;
			this._y += jChange.y;
			
			this.flow.dispatchUpdate(ActorsFeature.moveActor, this, jChange, this.movingCooldown + 1);
			
			this.view.moveNormally(this, jChange, this.movingCooldown + 1);
			this.view.jump(jChange, this.movingCooldown + 1);
			
			this.onMoved(jChange, this.movingCooldown);
		}
		
		/****************
		**** Overridables
		****************/
		
		
		/** Called in the end of reset. */
		protected function onSpawned():void { }
		
		/** Called in the begging of act(). */
		protected function onActing():void { }
		
		/** Called if action cooldown expired. */
		protected function onCanAct():void { }
		
		/** Called if moving cooldown expired. */
		protected function onCanMove():void { }
		
		/** Called if moved succesfully */
		protected function onMoved(change:DCellXY, delay:int):void { }
		
		/** Called if can not move */
		protected function onBlocked(change:DCellXY):void { }
		
		/** Called if someone applies push. */
		protected function onPushed():void { }
		
		/** Called by the WindFeature. */
		protected function onWind(change:DCellXY):void { }
		
		/** Called when soldering is offered. */
		protected function onSoldered(solderer:ItemLogicBase):void { }
		
		/** Called if damaged and survived that damage. */
		protected function onDamaged(damage:int):void { }
		
		/** Called if actor is destroyed by something. */
		protected function onDestroyed():void { }
	}

}