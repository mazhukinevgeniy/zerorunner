package game.renderer 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.points.IPointCollector;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ProjectileRenderer extends QuadBatch
	{
		private var center:ICoordinated;
		
		private var points:IPointCollector;
		private var projectiles:IProjectileManager;
		
		private var shard:Quad;
		
		/* Used by getTrajectoryCoordinates() */
		private var tmpCell:CellXY;
		
		public function ProjectileRenderer(elements:GameElements) 
		{
			//TODO: let's try to render the projectile and its path at the same time
			
			this.points = elements.pointsOfInterest;
			this.projectiles = elements.projectiles;
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.quitGame);
			
			this.tmpCell = new CellXY(0, 0);
			
			this.shard = new Quad(int(Game.CELL_WIDTH * 0.7), int(Game.CELL_HEIGHT * 0.7), 0xFFFFFF);
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.center = this.points.getCharacter();
		}
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var x:int = this.center.x;
			var y:int = this.center.y;
			
			var proj:Projectile;
			var view:Quad;
			
			for (var i:int = -10; i < 11; i++)
				for (var j:int = -10; j < 11; j++)//TODO: replace hardcode with something good
				{
					proj = this.projectiles.getProjectile(x + i, y + j);
					
					if (proj)
					{
						if (proj.type == Game.PROJECTILE_SHARD)
						{
							view = this.shard;
							
							view.x = (x + i) * Game.CELL_WIDTH;
							view.y = (y + j) * Game.CELL_HEIGHT;
							
							view.x += (Game.CELL_WIDTH - view.width) / 2;
							view.y += (Game.CELL_HEIGHT - view.height) / 2;
							
							this.getTrajectoryCoordinates(proj.height);
							
							view.x += this.tmpCell.x;
							view.y += this.tmpCell.y;
							
							this.addQuad(view);
						}
					}
				}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function getTrajectoryCoordinates(height:int):void
		{
			const X_STEP:int = 8;
			const Y_STEP:int = -12;
			
			this.tmpCell.setValue(height * X_STEP, height * Y_STEP);
		}
	}

}