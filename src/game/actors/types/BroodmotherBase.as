package game.actors.types 
{
	import game.actors.ActorsFeature;
	import utils.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	
	public class BroodmotherBase 
	{
		private var type:Class;
		private var actors:Vector.<ActorLogicBase>;
		
		protected var flow:IUpdateDispatcher;
		
		public function BroodmotherBase()
		{
			
			
			
			this.actors = new Vector.<ActorLogicBase>();
		}
		
		final public function getActors():Vector.<ActorLogicBase>
		{
			return this.actors;
		}
		
		final public function refillActors():void
		{			
			var length:int = this.getActorsCap();
			var actor:ActorLogicBase;
			
			for (var i:int = 0; i < length; i++)
			{
				actor = this.actors[i];
				
				if (actor)
				{
					if (!actor.active)
						actor.reset();
				}
				else
				{
					actor = new this.type();
					
					this.flow.dispatchUpdate(ActorsFeature.addActor, actor); //TODO: apply instacache
				}
			}
		}
		
		final public function act():void
		{
			var length:int = this.actors.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.actors[i].act();
			}
		}
		
		protected function getActorsCap():int
		{
			throw new AbstractClassError();
		}
	}

}