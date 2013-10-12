package game.world.operators 
{
	import game.core.GameFoundations;
	import game.world.IActors;
	import game.world.items.utils.ItemLogicBase;
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
			flow.addUpdateListener(Update.numberedFrame);
			
			this.foundations = foundations;
		}
		
		update function prerestore():void
		{
			this.width = ((this.foundations.game).mapWidth + 2) * (this.foundations.game).sectorWidth;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_CLEAR_BORDERS)
			{
				var actors:IActors = this.foundations.actors;
				const DWIDTH:int = (this.foundations.game).sectorWidth / 2;
				
				var i:int, j:int;
				var actor:ItemLogicBase;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < DWIDTH; j++)
					{
						actor = actors.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = actors.findObjectByCell(i, this.width - (j + 1));
						
						if (actor)
							actor.applyDestruction();
					}
				for (i = 0; i < DWIDTH; i++)
					for (j = DWIDTH; j < this.width - DWIDTH; j++)
					{
						actor = actors.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = actors.findObjectByCell(this.width - (i + 1), j);
						
						if (actor)
							actor.applyDestruction();
					}
			}
		}
	}

}