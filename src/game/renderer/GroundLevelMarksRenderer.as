package game.renderer 
{
	import game.forceFields.IForceField;
	import game.GameElements;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	
	internal class GroundLevelMarksRenderer extends SubRendererBase
	{		
		private var projectiles:IProjectileManager;
		private var forceField:IForceField;
		
		private var shardIncView:Quad;
		private var forceFieldView:Quad;
		
		public function GroundLevelMarksRenderer(elements:GameElements) 
		{
			super(elements);
			
			this.projectiles = elements.projectiles;
			this.forceField = elements.forceFields;
			
			this.shardIncView = new Quad(16, 16, 0xFF0000);
			//this.forceFieldView = new Quad(Game.CELL_WIDTH - 8, Game.CELL_HEIGHT - 8, 0x444444);
			this.forceFieldView = new Quad(Game.CELL_WIDTH, Game.CELL_HEIGHT, 0x444444);
			
			this.forceFieldView.alpha = 0.4;
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
					
					view.x = x * Game.CELL_WIDTH;
					view.y = y * Game.CELL_HEIGHT;
					
					view.x += (Game.CELL_WIDTH - view.width) / 2;
					view.y += (Game.CELL_HEIGHT - view.height) / 2;
					
					this.addQuad(view);
				}
			}
			
			if (this.forceField.isCellCovered(x, y))
			{
				view = this.forceFieldView;
				
				view.x = x * Game.CELL_WIDTH;
				view.y = y * Game.CELL_HEIGHT;
				
				view.x += (Game.CELL_WIDTH - view.width) / 2;
				view.y += (Game.CELL_HEIGHT - view.height) / 2;
				
				this.addQuad(view);
			}
		}
		
		override protected function get range():int 
		{
			return 8;
		}
	}

}