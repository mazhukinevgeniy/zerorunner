package view.game.renderer.marks 
{
	import binding.IBinder;
	import model.interfaces.ICollectibles;
	import model.interfaces.IProjectiles;
	import model.projectiles.Projectile;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import utils.getCellId;
	import view.game.renderer.structs.Changes;
	import view.game.renderer.SubRendererBase;
	
	public class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectiles;
		private var collectibles:ICollectibles;
		
		private var shardIncView:Image;
		private var collectibleView:Image;
		
		public function GroundLevelMarksRenderer(binder:IBinder) 
		{
			this.projectiles = binder.projectiles;
			this.collectibles = binder.collectibles;
			
			var atlas:TextureAtlas = binder.assetManager.getTextureAtlas(View.MAIN_ATLAS);
			
			this.shardIncView = 
				new Image(atlas.getTexture("shard_incoming_mark"));
			this.collectibleView = 
				new Image(atlas.getTexture("tmp_collectible"));
			
			
			var changes:Changes = new Changes();
			changes._dx = -(View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes.dx = (View.CELLS_IN_VISIBLE_WIDTH / 2 + 3);
			changes._dy = -(View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			changes.dy = (View.CELLS_IN_VISIBLE_HEIGHT / 2 + 3);
			
			super(binder, changes);
		}
		
		override protected function renderCell(x:int, y:int):void 
		{
			var cellId:int = getCellId(x, y);
			var proj:Projectile = this.projectiles.getProjectile(cellId);
			
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
			
			if (this.collectibles.findCollectible(cellId))
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