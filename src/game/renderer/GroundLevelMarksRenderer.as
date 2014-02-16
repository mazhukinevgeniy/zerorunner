package game.renderer 
{
	import game.GameElements;
	import game.metric.ICoordinated;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class GroundLevelMarksRenderer extends QuadBatch
	{		
		private var projectiles:IProjectileManager;
		
		private var shardIncView:Quad;
		
		private var center:ICoordinated;
		
		public function GroundLevelMarksRenderer(elements:GameElements) 
		{
			super();
			
			this.projectiles = elements.projectiles;
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.quitGame);
			
			this.shardIncView = new Quad(16, 16, 0xFF0000);
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		update function numberedFrame(frame:int):void
		{
			var view:Quad;
			
			this.reset();
			
			var x:int = this.center.x;
			var y:int = this.center.y;
			
			var proj:Projectile;
			
			for (var i:int = -10; i < 11; i++)
				for (var j:int = -10; j < 11; j++)//TODO: replace hardcode with something good
				{
					proj = this.projectiles.getProjectile(x + i, y + j);
					
					if (proj)
					{
						if (proj.type == Game.PROJECTILE_SHARD)
						{
							view = this.shardIncView;
							
							view.x = (x + i) * Game.CELL_WIDTH;
							view.y = (y + j) * Game.CELL_HEIGHT;
							
							view.x += (Game.CELL_WIDTH - view.width) / 2;
							view.y += (Game.CELL_HEIGHT - view.height) / 2;
							
							this.addQuad(view);
						}
					}
				}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
	}

}