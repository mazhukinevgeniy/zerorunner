package game.renderer 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ProjectileRenderer extends QuadBatch
	{
		private var center:ICoordinated;
		
		private var projectiles:IProjectileManager;
		
		private var shard:Image;
		private var trajectory:Image;
		
		/* Used by getTrajectoryCoordinates() */
		private var tmpCell:CellXY;
		
		public function ProjectileRenderer(elements:GameElements) 
		{
			this.projectiles = elements.projectiles;
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.quitGame);
			
			this.tmpCell = new CellXY(0, 0);
			
			this.shard = new Image(elements.assets.getTextureAtlas("sprites").getTexture("stone_fly"));
			this.trajectory = new Image(elements.assets.getTextureAtlas("sprites").getTexture("progress-bar-fill-skin"));
			
			
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		update function numberedFrame(frame:int):void
		{
			this.reset();
			
			var x:int = this.center.x;
			var y:int = this.center.y;
			
			var proj:Projectile;
			var view:Image;
			
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
							
							this.getTrajectoryCoordinates(proj.height);
							
							view.x += this.tmpCell.x;
							view.y += this.tmpCell.y;
							
							var tr:Image = this.trajectory;
							
							for (var k:int = 0; k < proj.height; k++)
							{
								tr.x = (x + i) * Game.CELL_WIDTH;
								tr.y = (y + j) * Game.CELL_HEIGHT;
								
								this.getTrajectoryCoordinates(k);
								
								tr.x += this.tmpCell.x;
								tr.y += this.tmpCell.y;
								
								this.addImage(tr);
							}
							
							this.addImage(view);
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
			const X_STEP:int = 3;
			const Y_STEP:int = 30;
			
			//this.tmpCell.setValue(height * X_STEP, 
			//					  ((Game.MAX_PROJ_HEIGHT - height) * (Game.MAX_PROJ_HEIGHT - height) * Y_STEP / 10) - Game.MAX_PROJ_HEIGHT * Game.MAX_PROJ_HEIGHT * Y_STEP / 10);
			
			this.tmpCell.setValue(height * X_STEP,
								  -height * Y_STEP);
		}
	}

}