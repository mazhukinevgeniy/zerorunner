package game.items 
{
	import game.broods.BroodmotherBase;
	import game.broods.BroodsFeature;
	import game.broods.IGiveBroods;
	import game.broods.ItemLogicBase;
	import game.input.IKnowInput;
	import game.metric.ICoordinated;
	import game.time.Time;
	import game.utils.GameFoundations;
	import game.world.ISearcher;
	import game.world.SearcherFeature;
	import starling.utils.AssetManager;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace update;
	
	internal class ActorStorage
	{
		protected var broods:Vector.<BroodmotherBase>;
		
		
		public function ActorStorage(foundations:GameFoundations, broods:IGiveBroods) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.broods = new Vector.<BroodmotherBase>();
			
			this.broods.push(broods.getBrood(BroodsFeature.CHARACTER));
			this.broods.push(broods.getBrood(BroodsFeature.CHECKPOINT));
			this.broods.push(broods.getBrood(BroodsFeature.FOG));
			this.broods.push(broods.getBrood(BroodsFeature.SKY_CLEARER));
			this.broods.push(broods.getBrood(BroodsFeature.TECHNIC));
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(UpdateGameBase.prerestore);
			flow.addUpdateListener(Time.tick);
			flow.addUpdateListener(Time.aftertick);
			flow.addUpdateListener(SearcherFeature.cacheActors);
			
			new WindFeature(flow);
		}
		
		update function cacheActors(cache:Vector.<ItemLogicBase>, center:ICoordinated, width:int, height:int):void
		{			
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				var actors:Vector.<ItemLogicBase> = this.broods[i].getActors();
				var alength:int = actors.length;
				
				for (var j:int = 0; j < alength; j++)
				{
					var actor:ItemLogicBase = actors[j];
					
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
				}
			}
			
		}
		
		
		update function prerestore():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
		
		update function tick():void
		{
			var blength:int = this.broods.length;
			
			for (var i:int = 0; i < blength; i++)
			{
				this.broods[i].act();
			}
		}
		
		update function aftertick():void
		{
			var length:int = this.broods.length;
			
			for (var i:int = 0; i < length; i++)
				this.broods[i].refillActors();
		}
	}

}