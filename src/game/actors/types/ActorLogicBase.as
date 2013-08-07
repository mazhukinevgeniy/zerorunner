package game.actors.types 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.errors.AbstractClassError;
	import game.actors.view.IActorListener;
	import game.input.IKnowInput;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.IScene;
	
	public class ActorBase extends ActorCoreActions
	{
		internal static var iFlow:IUpdateDispatcher;
		internal static var iSearcher:ISearcher;
		internal static var iScene:IScene;
		internal static var iListener:IActorListener;
		internal static var iInput:IKnowInput;
		
		private var helperCharacter:CellXY;
		
		public function ActorBase(hp:int, moveSpeed:int, actionSpeed:int) 
		{
			this.hp = hp;
			
			this.moveSpeed = moveSpeed;
			this.actionSpeed = actionSpeed;
			
			this.cell = new CellXY(0, 0);
			this.helperCharacter = new CellXY(0, 0);//TODO: optimize
		}
		
		final public function reset(id:int):void
		{
			this.id = id;
			
			this.isActive = true;
			
			this.actingCooldown = 0;
			this.movingCooldown = 0;
			
			this.setSpawningCell();
			
			this.onSpawned();
		}
		
		protected function setSpawningCell():void
		{
			var x:int = ActorBase.iSearcher.character.x - Metric.xDistanceActorsAllowed / 2;
			var y:int = ActorBase.iSearcher.character.y - Metric.yDistanceActorsAllowed / 2;
			
			ActorBase.iSearcher.getCharacterCell(this.helperCharacter); 
			
			do 
			{
				this.cell.setValue(x + Metric.xDistanceActorsAllowed * Math.random(),
								   y + Metric.yDistanceActorsAllowed * Math.random());
			}
			while (Metric.distance(this.helperCharacter, this.cell) < 6 || ActorBase.iSearcher.findObjectByCell(this.x, this.y) != null);
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
		
		
		/**
		 * Informer access methods
		 */
		
		final protected function get scene():IScene
		{
			return ActorBase.iScene;
		}
		final protected function get searcher():ISearcher
		{
			return ActorBase.iSearcher;
		}
		final protected function get listener():IActorListener
		{
			return ActorBase.iListener;
		}
		final protected function get input():IKnowInput
		{
			return ActorBase.iInput;
		}
		
		
		/**
		 * DANGER: force methods
		 */
		
		final protected function forceActive(value:Boolean):void
		{
			this.isActive = value;
		}
		
		final protected function forceUpdate(... args):void
		{
			ActorBase.iFlow.dispatchUpdate.apply(ActorBase.iFlow, args);
		}
		
		//TODO: organize code
		
		final protected function tryMove(change:DCellXY):void
		{
			if (!ActorBase.iSearcher.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				this.movingCooldown = this.moveSpeed;
				
				this.cell.applyChanges(change);
				ActorBase.iFlow.dispatchUpdate(ActorsFeature.moveActor, this, change, this.movingCooldown + 1);
				
				this.onMoved(change, this.moveSpeed);
			}
			else
				this.onBlocked(change);
		}
		
		final protected function jump(change:DCellXY, multiplier:int):void
		{
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
		}
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.iScene.getSceneCell(item.x, item.y) == SceneFeature.FALL)
			{
				this.destroyActor(item);
			}
		}
		
		final protected function damageActor(item:ActorBase, damage:int):void
		{
			if (this.actingCooldown < 0)
			{
				item.hp -= damage;
				
				if (item.hp > 0)
				{
					item.onDamaged(damage);
				}
				else
				{
					this.destroyActor(item);
				}
				
				this.actingCooldown = this.actionSpeed;
			}
			else this.actingCooldown--;
		}
		
		private function destroyActor(item:ActorBase):void
		{
			if (item.isActive)
			{
				ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, item.id);
				
				item.onDestroyed();
			}
		}
		
		/**
		 * Called in the end of reset.
		 */
		protected function onSpawned():void
		{ 
			
		}
		
		
		/**
		 * Called in the begging of act().
		 */
		protected function onActing():void
		{ 
			
		}
		/**
		 * Called if action cooldown expired.
		 */
		protected function onCanAct():void
		{
			
		}
		/**
		 * Called if moving cooldown expired.
		 */
		protected function onCanMove():void
		{
			
		}
		/**
		 * Called if moved succesfully
		 */
		protected function onMoved(change:DCellXY, delay:int):void
		{
			
		}
		/**
		 * Called if can not move
		 */
		protected function onBlocked(change:DCellXY):void
		{
			
		}
		
		/**
		 * Called if damaged and survived that damage.
		**/
		protected function onDamaged(damage:int):void
		{
			
		}
		
		/**
		 * Called if actor is destroyed by something.
		 */
		protected function onDestroyed():void
		{
			
		}
	}

}