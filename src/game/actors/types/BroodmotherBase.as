package game.actors.types 
{
	import game.actors.ActorsFeature;
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
		
		private var type:Class;
		private var argument:*;
		
		private var actors:Vector.<ActorLogicBase>;
		
		protected var flow:IUpdateDispatcher;
		
		public function BroodmotherBase(type:Class, argument:*)
		{
			this.type = type;
			this.argument = argument;
			
			this.actors = new Vector.<ActorLogicBase>();
			
			this.flow = BroodmotherBase.flow;
		}
		
		final public function getActors():Vector.<ActorLogicBase>
		{
			return this.actors;
		}
		
		final public function refillActors():void
		{			
			var length:int = this.getActorsCap();
			var actor:ActorLogicBase;
			
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
						actor = new this.type(this.argument);
						actor.reset();
						
						this.flow.dispatchUpdate(ActorsFeature.addActor, actor);
					}
				}
				else
				{
					actor = this.actors[i] = new this.type(this.argument);
					actor.reset();
					
					this.flow.dispatchUpdate(ActorsFeature.addActor, actor);
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