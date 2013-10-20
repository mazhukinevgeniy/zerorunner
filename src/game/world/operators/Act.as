package game.world.operators 
{
	import game.core.metric.ICoordinated;
	import game.world.IActors;
	import game.world.items.IPointCollector;
	import game.world.items.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Act
	{
		private var points:IPointCollector;
		private var actors:IActors;
		
		private var moved:Vector.<ItemLogicBase>;
		
		public function Act(actors:IActors, flow:IUpdateDispatcher, points:IPointCollector) 
		{
			this.points = points;
			this.actors = actors;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.moved = new Vector.<ItemLogicBase>();
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_ACT)
			{
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
						actor = this.actors.findObjectByCell(i, j);
						
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