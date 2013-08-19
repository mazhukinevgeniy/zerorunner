package game.world.broods 
{
	import game.utils.GameFoundations;
	import game.utils.metric.CellXY;
	import game.world.ISearcher;
	import starling.animation.Juggler;
	import starling.textures.TextureAtlas;
	import utils.errors.AbstractClassError;
	import utils.updates.IUpdateDispatcher;
	
	public class BroodmotherBase 
	{
		private var actors:Vector.<ItemLogicBase>;
		
		protected var flow:IUpdateDispatcher;
		
		public function BroodmotherBase(foundations:GameFoundations)
		{
			this.flow = foundations.flow;
			
			this.refillActors();
		}
		
		private function refillActors():void
		{			
			var length:int = Math.max(this.getActorsCap());
			var actor:ItemLogicBase;
			
			var vlength:int = this.actors.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (i < vlength)
				{
					actor = this.actors[i];
					
					if (!actor)
					{
						actor = this.newActor();
						
						//this.flow.dispatchUpdate(Update.addActor, actor);
						//TODO: cache it
					}
				}
				else
				{
					actor = this.actors[i] = this.newActor();
					
				//	this.flow.dispatchUpdate(Update.addActor, actor);
				}//TODO: fix double code
			}
		}
		
		protected function newActor():ItemLogicBase
		{
			throw new AbstractClassError();
		}
		
		protected function getActorsCap():int
		{
			throw new AbstractClassError();
		}
		
	}

}