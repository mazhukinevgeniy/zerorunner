package game.broods 
{
	import game.items.ActorsFeature;
	import game.world.ISearcher;
	import starling.animation.Juggler;
	import starling.textures.TextureAtlas;
	import utils.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	
	public class BroodmotherBase 
	{
		internal static var gameAtlas:TextureAtlas;
		internal static var juggler:Juggler;
		
		internal static var world:ISearcher;
		internal static var flow:IUpdateDispatcher;
		
		private var actors:Vector.<ItemLogicBase>;
		
		protected var flow:IUpdateDispatcher;
		
		public function BroodmotherBase()
		{
			this.flow = BroodmotherBase.flow;
		}
		
		final public function getActors():Vector.<ItemLogicBase>
		{
			return this.actors;
		}
		
		final public function refillActors():void
		{			
			var length:int = Math.max(1, this.getActorsCap() / 2); //TODO: return to the regular syntax
			var actor:ItemLogicBase;
			
			var vlength:int = this.actors.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (i < vlength)
				{
					actor = this.actors[i];
					
					if (actor)
					{
						if (!actor.active)
							actor.reset();
					}
					else
					{
						actor = this.newActor();
						actor.reset();
						
						this.flow.dispatchUpdate(ActorsFeature.addActor, actor);
						//TODO: is it to be used?
					}
				}
				else
				{
					actor = this.actors[i] = this.newActor();
					actor.reset();
					
					this.flow.dispatchUpdate(ActorsFeature.addActor, actor);
				}
			}
		}
		
		protected function newActor():ItemLogicBase
		{
			throw new AbstractClassError();
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
		
		internal function reset():void
		{
			this.actors = new Vector.<ItemLogicBase>();
		}
		
		
		/** Called if actor can not be cached. */
		public function actorOutOfCache(actor:ItemLogicBase):void { }
	}

}