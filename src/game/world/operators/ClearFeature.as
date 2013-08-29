package game.world.operators 
{
	import game.utils.GameFoundations;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ClearFeature 
	{
		private var width:int;
		
		private var foundations:GameFoundations;
		
		public function ClearFeature(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.freeFrame);
			
			this.foundations = foundations;
		}
		
		update function prerestore():void
		{
			this.width = ((this.foundations.game).mapWidth + 2) * Game.SECTOR_WIDTH;
		}
		
		update function freeFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_CLEAR_BORDERS)
			{
				var world:ISearcher = this.foundations.world;
				
				var i:int, j:int;
				var actor:ItemLogicBase;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < 20; j++)
					{
						actor = world.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = world.findObjectByCell(i, this.width - (j + 1));
						
						if (actor)
							actor.applyDestruction();
					}
				for (i = 0; i < 20; i++)
					for (j = 20; j < this.width - 20; j++)
					{
						actor = world.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = world.findObjectByCell(this.width - (i + 1), j);
						
						if (actor)
							actor.applyDestruction();
					}
			}
		}
	}

}