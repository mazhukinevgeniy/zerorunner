package game.ui.renderer 
{
	import game.GameElements;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	internal class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectileManager;
		
		private var shardIncView:Image;
		
		public function GroundLevelMarksRenderer(elements:GameElements, layer:QuadBatch) 
		{
			super(elements, layer);
			
			this.projectiles = elements.projectiles;
			
			var atlas:TextureAtlas = elements.assets.getTextureAtlas("sprites");
			
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
					
					view.x = x * Game.CELL_WIDTH;
					view.y = y * Game.CELL_HEIGHT;
					
					view.scaleX = view.scaleY = scalingFactor;
					
					view.x += (Game.CELL_WIDTH - view.width) / 2;
					view.y += (Game.CELL_HEIGHT - view.height) / 2;
					
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