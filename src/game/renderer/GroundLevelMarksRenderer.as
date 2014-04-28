package game.renderer 
{
	import game.GameElements;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	
	internal class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectileManager;
		
		private var shardIncView:Quad;
		
		public function GroundLevelMarksRenderer(elements:GameElements, layer:QuadBatch) 
		{
			super(elements, layer);
			
			this.projectiles = elements.projectiles;
			
			this.shardIncView = new Quad(16, 16, 0xFF0000);
		}
		
		override protected function renderCell(x:int, y:int, frame:int):void 
		{
			var proj:Projectile = this.projectiles.getProjectile(x, y);
			
			var view:Quad;
			
			if (proj)
			{
				if (proj.type == Game.PROJECTILE_SHARD)
				{
					view = this.shardIncView;
					
					var scalingFactor:Number = 1 - proj.height / Game.MAX_PROJ_HEIGHT;
					
					view.x = x * Game.CELL_WIDTH;
					view.y = y * Game.CELL_HEIGHT;
					
					view.scaleX = view.scaleY = scalingFactor;
					
					view.x += (Game.CELL_WIDTH - view.width) / 2;
					view.y += (Game.CELL_HEIGHT - view.height) / 2;
					
					this.layer.addQuad(view);
				}
			}
		}
		
		override protected function get range():int 
		{
			return 8;
		}
	}

}