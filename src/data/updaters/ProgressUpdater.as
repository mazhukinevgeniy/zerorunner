package data.updaters 
{
	import data.Defaults;
	import data.viewers.GameConfig;
	import flash.utils.Proxy;
	import game.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ProgressUpdater 
	{
		private var save:Proxy;
		private var flow:IUpdateDispatcher;
		
		public function ProgressUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.droidUnlocked);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.progressDefaults)
				this.save[value] = Defaults.progressDefaults[value];
		}
		
		update function droidUnlocked(place:ICoordinated):void
		{
			this.save["activeDroids"]++;
		}
		
		update function numberedFrame(key:int):void
		{
			/*
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
				if (this.save["goal"] == Game.GOAL_LIGHT_A_BEACON) //стоит цель...
					if (this.save["beacon" + String(this.save["level"])] != Game.CONTRAIL_NO_BEACON)//выполнен критерий...
					{
						//кабум
					}
					
			*/
		}
		
	}

}