package game.projectiles 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Projectiles implements IProjectileManager
	{
		private var projectiles:Array;
		private var projectilesToStore:Vector.<Projectile>;
		private var unusedProjectiles:Vector.<Projectile>;
		
		private var clouds:Vector.<CloudBase>;
		
		private var flow:IUpdateDispatcher;
		
		public function Projectiles(elements:GameElements) 
		{
			this.flow = elements.flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.prerestore);
			this.flow.addUpdateListener(Update.projectileLaunched);
			this.flow.addUpdateListener(Update.projectileLanded);
			this.flow.addUpdateListener(Update.numberedFrame);
			this.flow.addUpdateListener(Update.quitGame);
			
			this.projectilesToStore = new Vector.<Projectile>();
			this.unusedProjectiles = new Vector.<Projectile>();
			
			this.clouds = new Vector.<CloudBase>();
			this.clouds.push(new TemporaryCloud(elements));
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.projectiles = new Array();
		}
		
		update function numberedFrame(frame:int):void
		{
			for each (var projectile:Projectile in this.projectiles)
			{
				projectile.advance();
			}
			
			
			var proj:Projectile;
			
			while (proj = this.projectilesToStore.pop())
			{
				var cell:ICoordinated = proj.cell;
			
				delete this.projectiles[cell.x + cell.y * Game.MAP_WIDTH];
				
				this.unusedProjectiles.push(proj);
			}
			
			if (frame == Game.FRAME_TO_RUN_CATACLYSM)
			{
				for (var i:int = 0; i < this.clouds.length; i++)
				{
					this.clouds[i].spawnProjectiles();
				}
			}
		}
		
		update function projectileLaunched(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			this.projectiles[cell.x + Game.MAP_WIDTH * cell.y] = projectile.type;
		}
		
		update function projectileLanded(projectile:Projectile):void
		{
			this.projectilesToStore.push(projectile);
		}
		
		update function quitGame():void
		{
			this.projectiles = null;
		}
		
		
		internal function getNewProjectile(type:int, x:int, y:int):Projectile
		{
			var projectile:Projectile = this.unusedProjectiles.pop();
			
			if (projectile)
				projectile.reassign(type, x, y);
			else
				projectile = new Projectile(this.flow, type, x, y);
			
			return projectile;
		}
		
		
		public function getProjectile(x:int, y:int):Projectile
		{
			x = (x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			y = (y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			return this.projectiles[x + y * Game.MAP_WIDTH];
		}
	}

}