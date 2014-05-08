package model.projectiles 
{
	import controller.observers.game.INewGameHandler;
	import model.interfaces.IProjectiles;
	
	public class Projectiles implements IProjectiles, INewGameHandler
	{
		private var projectiles:Array;
		private var unusedProjectiles:Vector.<Projectile>;
		
		private var clouds:Vector.<CloudBase>;
		
		private var flow:IUpdateDispatcher;
		private var items:Items;
		private var scene:IScene;
		private var controller:ProjectileController;
		
		public function Projectiles(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.scene = elements.scene;
			this.items = elements.items;
			this.controller = elements.projectileController;
			
			elements.restorer.addSubscriber(this);
			
			this.flow.workWithUpdateListener(this);
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
		
		/**///As IProjectiles
		
		public function getProjectile(x:int, y:int):Projectile
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.projectiles[x + y * Game.MAP_WIDTH];
		}
		
		/**/
		
		
		/**///As IRestorable
		
		public function restore():void
		{
			this.projectiles = new Array();
		}
		
		/**/
		
		
		/**///Internal goods
		
		internal function denyProjectile(projectile:Projectile):void
		{
			this.deleteProjectile(projectile);
		}
		
		internal function launchProjectile(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			this.projectiles[cell.x + Game.MAP_WIDTH * cell.y] = projectile;
		}
		
		internal function landProjectile(projectile:Projectile):void
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
					//TODO: remove this, and the whole "this.flow" thing falls!
				}
			}
		}
		
		internal function getNewProjectile(type:int, x:int, y:int):void
		{
			var projectile:Projectile = this.unusedProjectiles.pop();
			
			if (projectile)
				projectile.reassign(type, x, y);
			else
				new Projectile(this.controller, type, x, y);
		}
		
		/**/
		
		/**///Update methods
		
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
		
		update function quitGame():void
		{
			this.projectiles = null;
		}
		
		/**/
		
		
		/**///Private methods
		
		private function deleteProjectile(projectile:Projectile):void
		{
			var cell:ICoordinated = projectile.cell;
			
			delete this.projectiles[cell.x + cell.y * Game.MAP_WIDTH];
			
			this.unusedProjectiles.push(projectile);
		}
		
		/**/
	}

}