package game.projectiles 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Projectiles implements IProjectileManager
	{
		private var projectiles:Array;
		
		public function Projectiles(elements:GameElements) 
		{
			//TODO: generate "clouds", which are supposed to act as something meaningful and spawn singular projectiles
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.quitGame);
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.projectiles = new Array();
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_RUN_CATACLYSM)
			{
				
			}
		}
		
		update function quitGame():void
		{
			this.projectiles = null;
		}
		
		
		
		public function getProjectile(x:int, y:int):Projectile
		{
			x = (x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			y = (y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			return this.projectiles[x + y * Game.MAP_WIDTH];
		}
	}

}