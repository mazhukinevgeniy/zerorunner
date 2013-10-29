package game.items.utils 
{
	import data.viewers.GameConfig;
	import game.items.ItemBase;
	import game.items.Items;
	import game.items.items_internal;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace items_internal;
	
	internal class Clear
	{
		private var width:int;
		private var items:Items;
		
		public function Clear(items:Items, flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.items = items;
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
				var item:ItemBase;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < DWIDTH; j++)
					{
						item = this.items.findObjectByCell(i, j);
						
						if (item)
							item.applyDestruction();
						
						item = this.items.findObjectByCell(i, this.width - (j + 1));
						
						if (item)
							item.applyDestruction();
					}
				for (i = 0; i < DWIDTH; i++)
					for (j = DWIDTH; j < this.width - DWIDTH; j++)
					{
						item = this.items.findObjectByCell(i, j);
						
						if (item)
							item.applyDestruction();
						
						item = this.items.findObjectByCell(this.width - (i + 1), j);
						
						if (item)
							item.applyDestruction();
					}
			}
		}
	}

}