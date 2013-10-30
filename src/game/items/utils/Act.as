package game.items.utils 
{
	import game.core.metric.ICoordinated;
	import game.items.ItemBase;
	import game.items.Items;
	import game.points.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	
	internal class Act
	{
		private var points:IPointCollector;
		private var items:Items;
		
		private var moved:Vector.<ItemBase>;
		
		public function Act(items:Items, flow:IUpdateDispatcher, points:IPointCollector) 
		{
			this.points = points;
			this.items = items;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.moved = new Vector.<ItemBase>();
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_ACT)
			{
				var center:ICoordinated = this.points.getCharacter();
				
				const tlcX:int = center.x - 20;
				const tlcY:int = center.y - 20;
				
				const brcX:int = center.x + 20;
				const brcY:int = center.y + 20;
				
				var item:ItemBase;
				
				var i:int;
				var j:int;
				
				this.moved.length = 0;
				
				for (j = tlcY; j < brcY; j++)
				{				
					for (i = tlcX; i < brcX; i++)
					{
						item = this.items.findObjectByCell(i, j);
						
						if (item && this.moved.indexOf(item) == -1)
						{
							item.act();
							this.moved.push(item);
						}
					}
				}
				
				var others:Vector.<ItemBase> = this.points.getAlwaysActives();
				var length:int = others ? others.length : 0;
				
				for (i = 0; i < length; i++)
				{
					item = others[i];
					
					if (this.moved.indexOf(item) == -1)
						item.act();
				}
			}
		}
	}

}