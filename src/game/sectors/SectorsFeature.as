package game.sectors 
{
	import game.IGame;
	import game.utils.GameFoundations;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SectorsFeature 
	{
		private var game:IGame;
		
		private var width:int;
		private var sectors:Vector.<NormalSector>;
		
		public function SectorsFeature(foundations:GameFoundations) 
		{
			this.game = foundations.game;
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(UpdateGameBase.prerestore);
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
		}
	}

}