package game.items.utils 
{
	import game.items.items_internal;
	import game.items.PuppetBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	use namespace items_internal;
	
	internal class Advance 
	{
		private var arr:Array;
		
		public function Advance(items:Array, flow:IUpdateDispatcher) 
		{
			this.arr = items;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_ACT)//TODO: check if troublesome
			{
				for each (var pup:PuppetBase in this.arr)
					pup.tickPassed();
			}
		}
	}

}