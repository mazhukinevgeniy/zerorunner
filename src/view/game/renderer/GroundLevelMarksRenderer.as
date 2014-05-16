package view.game.renderer 
{
	import binding.IBinder;
	import model.interfaces.ICollectible;
	import model.interfaces.IProjectiles;
	import model.projectiles.Projectile;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	internal class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectiles;
		private var collectibles:ICollectible;
		
		private var shardIncView:Image;
		private var collectibleView:Image;
		
		public function GroundLevelMarksRenderer(binder:IBinder) 
		{
			this.projectiles = binder.projectiles;
			this.collectibles = binder.collectible;
			
			var atlas:TextureAtlas = binder.assetManager.getTextureAtlas(View.MAIN_ATLAS);
			
			this.shardIncView = 
				new Image(atlas.getTexture("radio-hover-icon"));
			this.collectibleView = 
				new Image(atlas.getTexture("hslider-thumb-down-skin"));
			
			
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
					
					this.addImage(view);
				}
			}
			
			if (this.collectibles.findCollectible(x, y))
			{
				view = this.collectibleView;
				
				view.x = x * View.CELL_WIDTH;
				view.y = y * View.CELL_HEIGHT;
				
				view.x += (View.CELL_WIDTH - view.width) / 2;
				view.y += (View.CELL_HEIGHT - view.height) / 2;
				
				this.addImage(view);
			}
			//TODO: make sure projectile can't hit any important collectible
		}
	}

}