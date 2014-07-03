package model.projectiles 
{
	import binding.IBinder;
	import flash.geom.Rectangle;
	import model.interfaces.IScene;
	import utils.getCellId;
	
	public class ShardCloud extends CloudBase
	{
		private var projectiles:Projectiles;
		
		private var scene:IScene;
		
		private var tlcX:int;
		private var tlcY:int;
		
		private var width:int;
		private var height:int;
		
		public function ShardCloud(projectiles:Projectiles, binder:IBinder, area:Rectangle) 
		{
			this.projectiles = projectiles;
			
			this.scene = binder.scene;
			
			this.tlcX = area.x;
			this.tlcY = area.y;
			this.width = area.width;
			this.height = area.height;
		}
		
		override internal function spawnProjectiles():void 
		{
			const NUMBER_OF_SPAWNS:int = 1;
			const NUMBER_OF_TRIES:int = 1;
			
			for (var i:int = 0; i < NUMBER_OF_SPAWNS; i++)
			{
				var x:int, y:int;
				
				for (var j:int = 0; j < NUMBER_OF_TRIES; j++)
				{
					x = this.tlcX + this.width * Math.random();
					y = this.tlcY + this.height * Math.random();
					
					var cellId:int = getCellId(x, y);
					
					if (!this.projectiles.getProjectile(cellId) &&
					    this.scene.getSceneCell(cellId) == Game.SCENE_GROUND)
					{
						this.projectiles.getNewProjectile(Game.PROJECTILE_SHARD, x, y);
						
						break;
					}
				}
			}
		}
	}

}