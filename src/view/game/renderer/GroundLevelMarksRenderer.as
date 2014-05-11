package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.IProjectiles;
	import model.projectiles.Projectile;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	internal class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectiles;
		
		private var shardIncView:Image;
		
		public function GroundLevelMarksRenderer(binder:IBinder, layer:QuadBatch) 
		{
			super(binder, layer);
			
			this.projectiles = binder.projectiles;
			
			var atlas:TextureAtlas = binder.assetManager.getTextureAtlas("sprites");
			
			this.shardIncView = new Image(atlas.getTexture("radio-hover-icon"));
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var proj:Projectile = this.projectiles.getProjectile(x, y);
			
			var view:Image;
			
			if (proj)
			{
				if (proj.type == Game.PROJECTILE_SHARD)
				{
					view = this.shardIncView;
					
					var scalingFactor:Number = 1.5 - proj.height / Game.MAX_PROJ_HEIGHT;
					
					view.x = x * View.CELL_WIDTH;
					view.y = y * View.CELL_HEIGHT;
					
					view.scaleX = view.scaleY = scalingFactor;
					
					view.x += (View.CELL_WIDTH - view.width) / 2;
					view.y += (View.CELL_HEIGHT - view.height) / 2;
					
					this.layer.addImage(view);
				}
			}
		}
		
		override protected function get range():int 
		{
			return 8;
		}
	}

}