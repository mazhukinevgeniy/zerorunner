package game.world.operators 
{
	import game.utils.GameFoundations;
	import game.utils.metric.ICoordinated;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ActFeature 
	{
		private var points:IPointCollector;
		private var foundations:GameFoundations;
		
		private var moved:Vector.<ItemLogicBase>;
		
		public function ActFeature(foundations:GameFoundations, points:IPointCollector) 
		{
			this.points = points;
			this.foundations = foundations;
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.tick);
			
			this.moved = new Vector.<ItemLogicBase>();
		}
		
		update function tick():void
		{
			var data:ISearcher = this.foundations.world;
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 20;
			const tlcY:int = center.y - 20;
			
			const brcX:int = center.x + 20;
			const brcY:int = center.y + 20;
			
			var actor:ItemLogicBase;
			
			var i:int;
			var j:int;
			
			this.moved.length = 0;
			
			for (j = tlcY; j < brcY; j++)
			{				
				for (i = tlcX; i < brcX; i++)
				{
					actor = data.findObjectByCell(i, j);
					
					if (actor && this.moved.indexOf(actor) == -1)
					{
						actor.act();
						this.moved.push(actor);
					}
				}
			}
			
			var others:Vector.<ICoordinated> = this.points.getPointsOfInterest(Game.ALWAYS_ACTIVE);
			var length:int = others.length;
			
			for (i = 0; i < length; i++)
			{
				actor = others[i] as ItemLogicBase;
				
				if (this.moved.indexOf(actor) == -1)
					actor.act();
			}
		}
	}

}