package game.actors.types.clouds 
{
	import game.actors.types.ActorLogicBase;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.world.SearcherFeature;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class WindFeature 
	{
		private const DIVISION:int = 5;
		
		private var change:DCellXY = Metric.getRandomDCell();
		
		public function WindFeature(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(SearcherFeature.cacheActors);
		}
		
		update function cacheActors(cache:Vector.<ActorLogicBase>, center:ICoordinated, width:int, height:int):void
		{	
			if (Math.random() < 0.2) this.change = Metric.getRandomDCell();
			var step:int = Math.random() * this.DIVISION;
			
			var goal:int;
			var actor:ActorLogicBase;
			
			var i:int, j:int;
			
			if (this.change.x == 0)
			{
				if (change.y > 0)
				{
					goal = (step + 1) * int(width / this.DIVISION);
					
					for (i = step * int(width / this.DIVISION); i < goal; i++)
					{
						for (j = height - 1; j > -1; j--)
						{
							actor = cache[i + j * width];
							
							if (actor && actor is CloudLogicBase)
							{
								(actor as CloudLogicBase).applyMove(this.change);
							}
						}
					}
				}
				else
				{
					goal = (step + 1) * int(width / this.DIVISION);
					
					for (i = step * int(width / this.DIVISION); i < goal; i++)
					{
						for (j = 0; j < height; j++)
						{
							actor = cache[i + j * width];
							
							if (actor && actor is CloudLogicBase)
							{
								(actor as CloudLogicBase).applyMove(this.change);
							}
						}
					}
				}
			}
			else
			{
				if (change.x > 0)
				{
					goal = (step + 1) * int(height / this.DIVISION);
					
					for (i = width - 1; i > -1; i--)
					{
						for (j = step * int(height / this.DIVISION); j < goal; j++)
						{
							actor = cache[i + j * width];
							
							if (actor && actor is CloudLogicBase)
							{
								(actor as CloudLogicBase).applyMove(this.change);
							}
						}
					}
				}
				else
				{
					goal = (step + 1) * int(height / this.DIVISION);
					
					for (i = 0; i < width; i++)
					{
						for (j = step * int(height / this.DIVISION); j < goal; j++)
						{
							actor = cache[i + j * width];
							
							if (actor && actor is CloudLogicBase)
							{
								(actor as CloudLogicBase).applyMove(this.change);
							}
						}
					}
				}
			}
		}
		
	}

}