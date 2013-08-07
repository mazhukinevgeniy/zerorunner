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
	
	public class ActorLogicBase extends ActorPuppet
	{
		
		public function ActorLogicBase(moveSpeed:int, actionSpeed:int) 
		{
			this.moveSpeed = moveSpeed;
			this.actionSpeed = actionSpeed;
			
			this.cell = new CellXY(0, 0);
		}
		
		final public function reset(hp:int):void
		{
			this.hp = hp;
			
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
		
		/********
		 ** SETUP
		 *******/
		
		
		
		
		/*********
		 ** CHECKS
		 ********/
		
		final protected function isOnTheGround(item:ActorBase):void
		{
			if (ActorBase.iScene.getSceneCell(item.x, item.y) == SceneFeature.FALL)
			{
				this.destroyActor(item);
			}
		}
		
		/**********
		 ** ACTIONS
		 *********/
		
		
	}

}