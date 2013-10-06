package game.world.operators 
{
	import game.core.GameFoundations;
	import game.world.ISearcher;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ClearFeature 
	{
		public static const CLEAR_RANGE:int = Game.SECTOR_WIDTH / 2;
		//TODO: parametrize
		
		private var width:int;
		
		private var foundations:GameFoundations;
		
		public function ClearFeature(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.foundations = foundations;
		}
		
		update function prerestore():void
		{
			this.width = ((this.foundations.game).mapWidth + 2) * Game.SECTOR_WIDTH;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_CLEAR_BORDERS)
			{
				var world:ISearcher = this.foundations.world;
				const DWIDTH:int = ClearFeature.CLEAR_RANGE;
				
				var i:int, j:int;
				var actor:ItemLogicBase;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < DWIDTH; j++)
					{
						actor = world.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = world.findObjectByCell(i, this.width - (j + 1));
						
						if (actor)
							actor.applyDestruction();
					}
				for (i = 0; i < DWIDTH; i++)
					for (j = DWIDTH; j < this.width - DWIDTH; j++)
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