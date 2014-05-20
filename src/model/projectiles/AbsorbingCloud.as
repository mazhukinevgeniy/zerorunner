package model.projectiles 
{
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
		
		public function AbsorbingCloud(projectiles:Projectiles, x:int, y:int, width:int, height:int) 
		{
			this.projectiles = projectiles;
			
			this.tlcX = x;
			this.tlcY = y;
			this.width = width;
			this.height = height;
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