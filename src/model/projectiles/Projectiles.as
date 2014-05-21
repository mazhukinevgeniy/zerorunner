package model.projectiles 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.interfaces.IProjectileController;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.interfaces.IProjectiles;
	import model.interfaces.IScene;
	import model.metric.ICoordinated;
	import utils.getCellId;
	import utils.normalize;
	
	public class Projectiles implements IProjectiles, 
	                                    INewGameHandler, 
										IQuitGameHandler,
										IGameFrameHandler
	{
		private var projectiles:Array;
		private var unusedProjectiles:Vector.<Projectile>;
		
		private var clouds:Vector.<CloudBase>;
		
		private var scene:IScene;
		private var projectileController:IProjectileController;
		
		public function Projectiles(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.scene = binder.scene;
			this.projectileController = binder.projectileController;
			
			this.unusedProjectiles = new Vector.<Projectile>();
			
			this.clouds = new Vector.<CloudBase>();
			
			var map:XML = MapXML.getOne();
			
			if (map.objectgroup[1].@name != "ShardClouds")
				throw new Error("wrong map");
			if (map.objectgroup[2].@name != "ProjectileAbsorbers")
				throw new Error("wrong map");
			
			var shardClouds:XMLList = map.objectgroup[1].object;
			this.spawnClouds(shardClouds, ShardCloud);
			
			var absorbers:XMLList = map.objectgroup[2].object;
			this.spawnClouds(absorbers, AbsorbingCloud);
		}
		
		private function spawnClouds(list:XMLList, cloud:Class):void
		{
			const LENGTH:int = list.length();
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				var x:int = int(list[j].@x) / 70;
				var y:int = int(list[j].@y) / 70;
				
				var width:int = 1 + int(list[j].@width) / 70;
				var height:int = 1 + int(list[j].@height) / 70;
				
				this.clouds.push(new cloud(this, x, y, width, height));
			}
		}
		
		public function newGame():void
		{
			this.projectiles = new Array();
		}
		
		public function quitGame():void
		{
			this.projectiles = null;
		}
		
		public function gameFrame(frame:int):void
		{
			for each (var projectile:Projectile in this.projectiles)
			{
				projectile.advance();
			}
			
			
			if (frame == Game.FRAME_TO_RUN_CATACLYSM)
			{
				for (var i:int = 0; i < this.clouds.length; i++)
				{
					this.clouds[i].spawnProjectiles();
				}
			}
		}
		
		
		
		/**///As IProjectiles
		
		public function getProjectile(cellId:int):Projectile
		{
			return this.projectiles[cellId];
		}
		
		/**/
		
		internal function denyProjectile(projectile:Projectile):void
		{
			this.deleteProjectile(projectile);
		}
		
		/**///Internal goods
		
		internal function projectileLaunched(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			this.projectiles[getCellId(cell.x, cell.y)] = projectile;
		}
		
		internal function projectileLanded(projectile:Projectile):void
		{
			this.deleteProjectile(projectile);
			
			
			if (projectile.type == Game.PROJECTILE_SHARD)
			{
				this.projectileController.shardFellDown(projectile);
			}
		}
		
		internal function getNewProjectile(type:int, x:int, y:int):void
		{
			x = normalize(x);
			y = normalize(y);
			
			var projectile:Projectile = this.unusedProjectiles.pop();
			
			if (projectile)
				projectile.reassign(type, x, y);
			else
				new Projectile(this, type, x, y);
		}
		
		/**/
		
		
		/**///Private methods
		
		private function deleteProjectile(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			delete this.projectiles[getCellId(cell.x, cell.y)];
			
			this.unusedProjectiles.push(projectile);
		}
		
		/**/
	}

}