package game.world.items.winds 
{
	import game.core.GameFoundations;
	
	public class Winds 
	{
		
		public function Winds(foundations:GameFoundations) 
		{
			var width:int = (foundations.game.mapWidth + 2) * Game.SECTOR_WIDTH;
			/*
			var goal:int = width * width * 0.15; //TODO: parametrize 0.15
			for (var i:int = 0; i < goal; i++)
				new FogLogic(foundations);
			*/
		}
		
	}

}