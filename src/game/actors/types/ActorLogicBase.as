package game.actors.types 
{
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.scene.SceneFeature;
	import game.searcher.ISearcher;
	import utils.errors.AbstractClassError;
	
	public class ActorLogicBase implements ICoordinated
	{
		/**
		 * To set
		 */
		
		private var world:ISearcher;
		
		/**
		 * 
		 */
		
		private var moveSpeed:int;
		private var movingCooldown:int;
		
		private var actionSpeed:int;
		private var actingCooldown:int;
		
		private var _x:int;
		private var _y:int;
		
		private var _active:Boolean;
		private var _hp:int;
		
		public function ActorLogicBase(world:ISearcher) 
		{
			this.world = world;
		}
		
		
		
		final public function get x():int {	return this._x;	}
		final public function get y():int {	return this._y;	}
		
		final public function get active():Boolean { return this._active; }
		
		
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
		
		
		
		//TODO: organize code
		
		
		
		/********
		 ** SETUP
		 *******/
		
		final public function reset():void
		{
			var config:Object = this.getConfig();
			
			this._hp = config.hp;
			this.moveSpeed = config.moveSpeed;
			this.actionSpeed = config.actionSpeed;
			
			this._active = true;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			var cell:CellXY = this.getSpawningCell();
			this._x = cell.x;
			this._y = cell.y;
			
			this.onSpawned();
		}
		
		protected function getSpawningCell():CellXY
		{
			var x:int = character.x - Metric.xDistanceActorsAllowed / 2;
			var y:int = character.y - Metric.yDistanceActorsAllowed / 2;
			
			var character:ICoordinated = this.world.getCenter();
			
			var cell:CellXY = new CellXY(0, 0);
			
			do 
			{
				cell.setValue(x + Metric.xDistanceActorsAllowed * Math.random(),
							  y + Metric.yDistanceActorsAllowed * Math.random());
			}
			while (Metric.distance(character, cell) < 6 || this.world.findObjectByCell(cell.x, cell.y) != null);
			
			return cell;
		}
		
		protected function getConfig():Object
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
		 ** ACTIONS
		 *********/
		
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
				//this.flow.dispatchUpdate(ActorsFeature.removeActor, item.id);
				//TODO: do it correct way
				
				this.onDestroyed();
			}
		}
		
		final public function applyMove(change:DCellXY):void
		{
			if (!this.world.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this.movingCooldown = this.moveSpeed;
				
				this._x += change.x;
				this._y += change.y;
				//ActorBase.iFlow.dispatchUpdate(ActorsFeature.moveActor, this, change, this.movingCooldown + 1);
				//TODO: draw
				
				this.onMoved(change, this.moveSpeed);
			}
			else
				this.onBlocked(change);
		}
		
		final protected function applyJump(change:DCellXY, multiplier:int):void
		{
			/*
			this.movingCooldown = 2 * this.moveSpeed * multiplier;
			
			var jChange:DCellXY = new DCellXY(change.x * multiplier, change.y * multiplier);//TODO: do not allocate
			
			var unluckyGuy:ActorBase = ActorBase.iSearcher.findObjectByCell(this.x + jChange.x, this.y + jChange.y);
			if (unluckyGuy)
			{
				this.destroyActor(unluckyGuy);
			}
			
			this.cell.applyChanges(jChange);
			ActorBase.iFlow.dispatchUpdate(ActorsFeature.moveActor, this, jChange, this.movingCooldown + 1);
			
			ActorBase.iListener.actorJumped(this.id, jChange, this.movingCooldown + 1); //TODO: ensure that moveNormally is overridable
			
			this.onMoved(jChange, this.movingCooldown);
			*/
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
		
		/** Called if damaged and survived that damage. */
		protected function onDamaged(damage:int):void { }
		
		/** Called if actor is destroyed by something. */
		protected function onDestroyed():void { }
	}

}