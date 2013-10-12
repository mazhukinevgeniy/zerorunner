package game.world.operators 
{
	import game.core.GameFoundations;
	import game.core.metric.ICoordinated;
	import game.world.IActors;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ActFeature //TODO: fix the name, it's not okay
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
			flow.addUpdateListener(Update.numberedFrame);
			
			this.moved = new Vector.<ItemLogicBase>();
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_ACT)
			{
				var actors:IActors = this.foundations.actors;
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
						actor = actors.findObjectByCell(i, j);
						
						if (actor && this.moved.indexOf(actor) == -1)
						{
							actor.act();
							this.moved.push(actor);
						}
					}
				}
				
				var others:Vector.<ICoordinated> = this.points.getPointsOfInterest(Game.ALWAYS_ACTIVE);
				var length:int = others ? others.length : 0;
				
				for (i = 0; i < length; i++)
				{
					actor = others[i] as ItemLogicBase;
					
					if (this.moved.indexOf(actor) == -1)
						actor.act();
				}
			}
		}
	}

}