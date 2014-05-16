package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.IProjectiles;
	import model.metric.CellXY;
	import model.projectiles.Projectile;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	internal class ProjectileRenderer extends SubRendererBase
	{
		private var projectiles:IProjectiles;
		
		private var shard:Image;
		private var trajectory:Image;
		
		/* Used by getTrajectoryCoordinates() */
		private var tmpCell:CellXY;
		
		public function ProjectileRenderer(binder:IBinder) 
		{
			this.projectiles = binder.projectiles;
			
			this.tmpCell = new CellXY(0, 0);
			
			var atlas:TextureAtlas = binder.assetManager.getTextureAtlas(View.MAIN_ATLAS);
			
			this.shard = new Image(atlas.getTexture("stone_fly"));
			this.trajectory = new Image(atlas.getTexture("progress-bar-fill-skin"));
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH + 2);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT + 2);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT + 2);
			
			super(binder, changes);
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var proj:Projectile = this.projectiles.getProjectile(x, y);
			
			if (proj)
			{
				var view:Image;
				
				if (proj.type == Game.PROJECTILE_SHARD)
				{
					view = this.shard;
					
					view.x = x * View.CELL_WIDTH;
					view.y = y * View.CELL_HEIGHT;
					
					this.getTrajectoryCoordinates(proj.height);
					
					view.x += this.tmpCell.x - view.width / 2;
					view.y += this.tmpCell.y - view.height / 2;
					
					var tr:Image = this.trajectory;
					
					for (var k:int = 0; k < proj.height; k++)
					{
						tr.x = x * View.CELL_WIDTH;
						tr.y = y * View.CELL_HEIGHT;
						
						this.getTrajectoryCoordinates(k);
						
						tr.x += this.tmpCell.x - tr.width / 2;
						tr.y += this.tmpCell.y - tr.height / 2;
						
						this.addImage(tr);
					}
					
					this.addImage(view);
				}
			}
		}
		
		private function getTrajectoryCoordinates(height:int):void
		{
			const X_STEP:int = 3;
			const Y_STEP:int = 30;
			
			//this.tmpCell.setValue(height * X_STEP, 
			//					  ((Game.MAX_PROJ_HEIGHT - height) * (Game.MAX_PROJ_HEIGHT - height) * Y_STEP / 10) - Game.MAX_PROJ_HEIGHT * Game.MAX_PROJ_HEIGHT * Y_STEP / 10);
			
			this.tmpCell.setValue(height * X_STEP + View.CELL_WIDTH / 2,
								  -height * Y_STEP + View.CELL_HEIGHT / 2);
		}
	}

}