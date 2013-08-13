package game.actors.types.clouds 
{
	import game.actors.types.ActorLogicBase;
	import game.metric.ICoordinated;
	import game.world.SearcherFeature;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class WindFeature 
	{
		
		public function WindFeature(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(SearcherFeature.cacheActors);
		}
		
		update function cacheActors(cache:Vector.<ActorLogicBase>, center:ICoordinated, width:int, height:int):void
		{			/*
				var actors:Vector.<ActorLogicBase> = this.broods[i].getActors();
				var alength:int = actors.length;
				
				for (var j:int = 0; j < alength; j++)
				{
					var actor:ActorLogicBase = actors[j];
					
					if (actor.active)
					{
						var x:int = actor.x;
						var y:int = actor.y;
						
						if ((!(x < center.x - width / 2)) && (x < center.x + width / 2)
							&&
							(!(y < center.y - height / 2)) && (y < center.y + height / 2))
						{
							x -= center.x - width / 2;
							y -= center.y - height / 2;
							
							cache[x + y * width] = actor;
						}
						else
						{
							this.broods[i].actorOutOfCache(actor);
						}
					}
				}*/
		}
	}

}