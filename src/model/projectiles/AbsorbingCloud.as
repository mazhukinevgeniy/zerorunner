package model.projectiles 
{
	import binding.IBinder;
	import flash.geom.Rectangle;
	import utils.getCellId;
	
	/**
	 * Denies projectiles; it's anticloud actually. Anyway, it's super effective.
	 */
	internal class AbsorbingCloud extends CloudBase
	{
		private var projectiles:Projectiles;
		
		private var tlcX:int;
		private var tlcY:int;
		
		private var width:int;
		private var height:int;
		
		public function AbsorbingCloud(projectiles:Projectiles, binder:IBinder, area:Rectangle) 
		{
			this.projectiles = projectiles;
			
			this.tlcX = area.x;
			this.tlcY = area.y;
			this.width = area.width;
			this.height = area.height;
		}
		
		override internal function spawnProjectiles():void 
		{
			for (var x:int = this.tlcX; x < this.tlcX + this.width; x++)
				for (var y:int = this.tlcY; y < this.tlcY + this.height; y++)
				{
					var proj:Projectile = this.projectiles.getProjectile(getCellId(x, y));
					
					if (proj)
						this.projectiles.denyProjectile(proj);
				}
		}
	}

}