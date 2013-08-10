package game.actors 
{
	import game.actors.types.BroodmotherBase;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		private var flow:IUpdateDispatcher;
		
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.tick);
		}
		
		update function cacheActors(/*params*/):void
		{
			/*
				for (i = 0; i < this.state.actualActorsCap; i++)
				{
					actor = this.actors[i];
					
					if (this.canBeCached(actor))
					{
						x = actor.x; y = actor.y;
						
						if (this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width])
						{
							ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, actor.id);
						}
						else
						{
							this.cacheV[(x - this.tLC.x) + (y - this.tLC.y) * this.width] = actor;
						}
					}
					else if (actor.isActive)
					{
						ActorBase.iFlow.dispatchUpdate(ActorsFeature.removeActor, actor.id);
					}
				}
			*/
		}
		
		/*
		update function moveActor(actor:ActorBase, change:DCellXY, delay:int):void
		{
			this.putInCell(actor.x - change.x, actor.y - change.y);
			this.putInCell(actor.x, actor.y, actor);
		}
		
		update function removeActor(id:int):void
		{
			var actor:ActorBase = this.actors[id];
			
			actor.isActive = false;
			this.putInCell(actor.x, actor.y);
		}
		
		final protected function putInCell(x:int, y:int, item:ActorBase = null):void
		{
			if (!(x < this.tLC.x) && (x < this.tLC.x + this.width)
				&&
				!(y < this.tLC.y) && (y < this.tLC.y + this.height))
			this.cacheV[x - this.tLC.x + (y - this.tLC.y) * this.width] = item;
		}
		*/
		
		/*
		*/
		
		update function aftertick():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function prerestore():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function tick():void
		{
			var length:int = 0;//this.state.actualActorsCap;
			
			for (var i:int = 0; i < length; i++)
				return;//this.actors[i].act();
		}
		
		/*
		update function addActor(item:ActorPuppet):void
		{
			image.standOn(item.giveCell());
			
			this.container.addChild(image);
		}
		 */
	}

}