package game.renderer 
{
	import game.GameElements;
	import game.metric.CellXY;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Image;
	
	internal class ProjectileRenderer extends SubRendererBase
	{
		private var projectiles:IProjectileManager;
		
		private var shard:Image;
		private var trajectory:Image;
		
		/* Used by getTrajectoryCoordinates() */
		private var tmpCell:CellXY;
		
		public function ProjectileRenderer(elements:GameElements) 
		{
			this.projectiles = elements.projectiles;
			
			this.tmpCell = new CellXY(0, 0);
			
			this.shard = new Image(elements.assets.getTextureAtlas("sprites").getTexture("stone_fly"));
			this.trajectory = new Image(elements.assets.getTextureAtlas("sprites").getTexture("progress-bar-fill-skin"));
			
			super(elements);
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			var proj:Projectile = this.projectiles.getProjectile(x, y);
			
			if (proj)
			{
				var view:Image;
				
				if (proj.type == Game.PROJECTILE_SHARD)
				{
					view = this.shard;
					
					view.x = x * Game.CELL_WIDTH;
					view.y = y * Game.CELL_HEIGHT;
					
					this.getTrajectoryCoordinates(proj.height);
					
					view.x += this.tmpCell.x - view.width / 2;
					view.y += this.tmpCell.y - view.height / 2;
					
					var tr:Image = this.trajectory;
					
					for (var k:int = 0; k < proj.height; k++)
					{
						tr.x = x * Game.CELL_WIDTH;
						tr.y = y * Game.CELL_HEIGHT;
						
						this.getTrajectoryCoordinates(k);
						
						tr.x += this.tmpCell.x - tr.width / 2;
						tr.y += this.tmpCell.y - tr.height / 2;
						
						this.addImage(tr);
					}
					
					this.addImage(view);
				}
			}
		}
		
		override protected function get range():int 
		{
			return 10;
		}
		
		private function getTrajectoryCoordinates(height:int):void
		{
			const X_STEP:int = 3;
			const Y_STEP:int = 30;
			
			//this.tmpCell.setValue(height * X_STEP, 
			//					  ((Game.MAX_PROJ_HEIGHT - height) * (Game.MAX_PROJ_HEIGHT - height) * Y_STEP / 10) - Game.MAX_PROJ_HEIGHT * Game.MAX_PROJ_HEIGHT * Y_STEP / 10);
			
			this.tmpCell.setValue(height * X_STEP + Game.CELL_WIDTH / 2,
								  -height * Y_STEP + Game.CELL_HEIGHT / 2);
		}
	}

}