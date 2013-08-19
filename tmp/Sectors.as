package game.world 
{
	import game.IGame;
	import game.utils.GameFoundations;
	import game.utils.metric.ICoordinated;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Sectors 
	{
	private var game:IGame;
		private var searcher:ISearcher;
		
		private var width:int;
		private var sectors:Vector.<NormalSector>;
		
		private var center:int;
		
		public function Sectors(foundations:GameFoundations, searcher:ISearcher) 
		{
			this.game = foundations.game;
			this.searcher = searcher;
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.aftertick);
		}
		
		update function prerestore():void
		{
			this.width = (this.game).getMapWidth();
			
			var totalSectors:int = (this.width + 2) * (this.width + 2);
			this.sectors = new Vector.<NormalSector>(totalSectors, true);
			
			var i:int;
			
			this.sectors[0] = new EmptySector();
			for (i = 1; i < this.width + 1; i++)
			{
				this.sectors[i] = new EmptySector();
				this.sectors[totalSectors - (1 + i)] = new EmptySector();
				this.sectors[i * (this.width + 2)] = new EmptySector();
				this.sectors[(i + 1) * (this.width + 2) - 1] = new EmptySector();
			}
			this.sectors[totalSectors - 1] = new EmptySector();
			
			this.sectors[2 * (this.width + 1)] = new FinalSector();
			this.sectors[totalSectors - 2 * (this.width + 1)] = new SpawnSector();
			
			this.center = -1;
		}
		
		update function aftertick():void
		{
			var firstI:int, afterlastI:int;
			
			var centerSector:int = this.getCenterSector();
			
			if (centerSector != this.center)
			{
				if (false)
				{
					//TODO: check every real shift...
				}
				else
				{
					//TODO: if no normal interpretation is applicable, reinitialize
				}
			}
		}
		
		private function getCenterSector():int
		{
			var center:ICoordinated = this.searcher.getCenter();
			return int(center.x / this.SECTOR_WIDTH) + (this.width + 2) * int(center.y / this.SECTOR_WIDTH);
		}
	}

}