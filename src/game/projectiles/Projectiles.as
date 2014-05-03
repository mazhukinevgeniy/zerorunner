package game.projectiles 
{
	import game.GameElements;
	import game.interfaces.IRestorable;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import utils.MapXML;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Projectiles implements IProjectileManager, IRestorable
	{
		private var projectiles:Array;
		private var unusedProjectiles:Vector.<Projectile>;
		
		private var clouds:Vector.<CloudBase>;
		
		private var elements:GameElements;
		
		private var flow:IUpdateDispatcher;
		private var items:Items;
		private var scene:IScene;
		
		public function Projectiles(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.scene = elements.scene;
			
			this.elements = elements;
			
			elements.restorer.addSubscriber(this);
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.projectileLaunched);
			this.flow.addUpdateListener(Update.projectileLanded);
			this.flow.addUpdateListener(Update.numberedFrame);
			this.flow.addUpdateListener(Update.quitGame);
			
			this.unusedProjectiles = new Vector.<Projectile>();
			
			this.clouds = new Vector.<CloudBase>();
			
			var map:XML = MapXML.getOne();
			
			var clouds:XMLList = map.objectgroup[1].object;
			const LENGTH:int = clouds.length();
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				if (clouds[j].@type == "shards")
				{
					var x:int = int(clouds[j].@x) / 70;
					var y:int = int(clouds[j].@y) / 70;
					
					var width:int = 1 + int(clouds[j].@width) / 70;
					var height:int = 1 + int(clouds[j].@height) / 70;
					
					this.clouds.push(new ShardCloud(this, x, y, width, height));
				}
			}
		}
		
		public function denyProjectile(projectile:Projectile):void
		{
			this.deleteProjectile(projectile);
		}
		
		
		
		/**///As IRestorable
		
		public function restore():void
		{
			this.projectiles = new Array();
			
			this.items = elements.items;
		}
		
		/**/
		
		/**///As IProjectileManager
		
		public function getProjectile(x:int, y:int):Projectile
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.projectiles[x + y * Game.MAP_WIDTH];
		}
		
		/**/
		
		update function numberedFrame(frame:int):void
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
		
		update function projectileLaunched(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			this.projectiles[cell.x + Game.MAP_WIDTH * cell.y] = projectile;
		}
		
		update function projectileLanded(projectile:Projectile):void
		{
			this.deleteProjectile(projectile);
			
			
			if (projectile.type == Game.PROJECTILE_SHARD)
			{
				var x:int = projectile.cell.x;
				var y:int = projectile.cell.y;
				
				var target:PuppetBase = this.items.findAnyObjectByCell(x, y);
				
				if (target)
				{
					target.tryDestruction();
				}
				else if (this.scene.getSceneCell(x, y) == Game.SCENE_GROUND)
				{
					this.flow.dispatchUpdate(Update.dropShard, projectile);
				}
			}
		}
		
		update function quitGame():void
		{
			this.projectiles = null;
		}
		
		
		internal function getNewProjectile(type:int, x:int, y:int):void
		{
			var projectile:Projectile = this.unusedProjectiles.pop();
			
			if (projectile)
				projectile.reassign(type, x, y);
			else
				new Projectile(this.flow, type, x, y);
		}
		
		
		private function deleteProjectile(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			delete this.projectiles[cell.x + cell.y * Game.MAP_WIDTH];
			
			this.unusedProjectiles.push(projectile);
		}
	}

}