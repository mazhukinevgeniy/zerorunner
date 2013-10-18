package game.world.operators 
{
	import data.viewers.GameConfig;
	import game.world.IActors;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Clear
	{
		private var width:int;
		private var actors:IActors;
		
		public function Clear(actors:IActors, flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.actors = actors;
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.width = config.width + 2 * Game.BORDER_WIDTH;
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_CLEAR_BORDERS)
			{
				const DWIDTH:int = Game.BORDER_WIDTH / 2;
				
				var i:int, j:int;
				var actor:ItemLogicBase;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < DWIDTH; j++)
					{
						actor = this.actors.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = this.actors.findObjectByCell(i, this.width - (j + 1));
						
						if (actor)
							actor.applyDestruction();
					}
				for (i = 0; i < DWIDTH; i++)
					for (j = DWIDTH; j < this.width - DWIDTH; j++)
					{
						actor = this.actors.findObjectByCell(i, j);
						
						if (actor)
							actor.applyDestruction();
						
						actor = this.actors.findObjectByCell(this.width - (i + 1), j);
						
						if (actor)
							actor.applyDestruction();
					}
			}
		}
	}

}