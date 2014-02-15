package game.renderer 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.projectiles.Projectile;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class GroundLevelMarksRenderer extends QuadBatch
	{
		
		private var hasChanges:Boolean = false;
		//TODO: check if this flag helps
		
		private var marks:Array;
		
		private var shardIncView:Quad;
		
		
		public function GroundLevelMarksRenderer(elements:GameElements) 
		{
			super();
			
			this.marks = new Array();
			
			var flow:IUpdateDispatcher = elements.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.projectileLaunched);
			flow.addUpdateListener(Update.projectileLanded);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.quitGame);
			
			this.shardIncView = new Quad(4, 4, 0xFF0000);
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.hasChanges = false;
		}
		
		update function projectileLaunched(projectile:Projectile):void
		{
			this.hasChanges = true;
			
			var cell:ICoordinated = projectile.cell;
			
			this.marks[cell.x + Game.MAP_WIDTH * cell.y] = projectile.type;
		}
		
		update function projectileLanded(projectile:Projectile):void
		{
			this.hasChanges = true;
			
			var cell:ICoordinated = projectile.cell;
			
			delete this.marks[cell.x + cell.y * Game.MAP_WIDTH];
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_RUN_CATACLYSM && this.hasChanges)
			{
				var view:Quad;
				
				this.reset();
				
				for (var i:String in this.marks)
				{
					if (this.marks[i] == Game.PROJECTILE_SHARD)
					{
						view = this.shardIncView;
						
						view.x = int(i) % Game.MAP_WIDTH;
						view.y = (int(i) - view.x) / Game.MAP_WIDTH;
						
						view.x += (Game.CELL_WIDTH - view.width) / 2;
						view.y += (Game.CELL_HEIGHT - view.height) / 2;
						
						this.addQuad(view);
					}
				}
				
				this.hasChanges = false;
			}
		}
		
		update function quitGame():void
		{
			this.reset();
			
			this.marks.length = 0;
		}
	}

}