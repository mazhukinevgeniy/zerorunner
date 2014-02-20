package game.projectiles 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.Items;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Projectiles implements IProjectileManager
	{
		private var projectiles:Array;
		private var projectilesToStore:Vector.<Projectile>;
		private var unusedProjectiles:Vector.<Projectile>;
		
		private var clouds:Vector.<CloudBase>;
		
		private var flow:IUpdateDispatcher;
		private var items:Items;
		private var scene:IScene;
		
		public function Projectiles(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.items = elements.items;
			this.scene = elements.scene;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.restore);
			this.flow.addUpdateListener(Update.projectileLaunched);
			this.flow.addUpdateListener(Update.projectileLanded);
			this.flow.addUpdateListener(Update.numberedFrame);
			this.flow.addUpdateListener(Update.generatorPowered);
			this.flow.addUpdateListener(Update.quitGame);
			
			this.projectilesToStore = new Vector.<Projectile>();
			this.unusedProjectiles = new Vector.<Projectile>();
			
			this.clouds = new Vector.<CloudBase>();
			this.clouds.push(new TemporaryCloud(elements, this));
		}
		
		
		update function restore(config:GameConfig):void
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
			
			this.projectiles[cell.x + Game.MAP_WIDTH * cell.y] = projectile;
		}
		
		update function projectileLanded(projectile:Projectile):void
		{
			this.projectilesToStore.push(projectile);
			
			
			if (projectile.type == Game.PROJECTILE_SHARD)
			{
				var x:int = projectile.cell.x;
				var y:int = projectile.cell.y;
				
				var target:PuppetBase = this.items.findAnyObjectByCell(x, y);
				
				if (target)
				{
					target.master.tryDestructionOn(target);
				}
				else if (this.scene.getSceneCell(x, y) == Game.SCENE_GROUND)
				{
					this.flow.dispatchUpdate(Update.dropShard, projectile);
				}
			}
		}
		
		update function generatorPowered(x:int, y:int):void
		{
			//TODO: remove hardcode
			var tx:int, ty:int;
			
			for (var i:int = -7; i < 8; i++)
				for (var j:int = -7; j < 8; j++)
				{
					tx = normalize(x + i);
					ty = normalize(y + j);
					
					var proj:Projectile = this.projectiles[tx + ty * Game.MAP_WIDTH];
					
					if (proj)
					{
						this.projectilesToStore.push(proj);
						//TODO: check if that's enough
						//TODO: check if immersion breaking
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
		
		
		public function getProjectile(x:int, y:int):Projectile
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.projectiles[x + y * Game.MAP_WIDTH];
		}
	}

}