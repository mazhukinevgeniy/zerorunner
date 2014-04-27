package game.items.checkpoint 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items._utils.CheckpointMasterBase;
	import game.items.PuppetBase;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.projectiles.IProjectileManager;
	import game.projectiles.Projectile;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class CheckpointMaster extends CheckpointMasterBase
	{
		private var flow:IUpdateDispatcher;
		private var projectiles:IProjectileManager;
		
		private var center:ICoordinated; 
		//not used now but might help if checkpoints grow in importance
		
		private var checkpoints:Vector.<Checkpoint>;
		
		public function CheckpointMaster(elements:GameElements) 
		{
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			
			super(elements);
			
			this.checkpoints = new Vector.<Checkpoint>();
		}
		
		override protected function onGameStarted():void 
		{
			this.flow = this.elements.flow;
			this.projectiles = this.elements.projectiles;
		}
		
		override protected function onGameFinished():void 
		{
			this.checkpoints.length = 0;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.checkpoints.push(
				new Checkpoint(this, this.elements, new CellXY(x, y)));
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
		}
		
		override protected function getReachedCheckpoint():ICoordinated 
		{
			for each (var checkpoint:Checkpoint in this.checkpoints)
			{
				var x:int = checkpoint.x;
				var y:int = checkpoint.y;
				
				for (var i:int = -1; i < 2; i++)
					for (var j:int = -1; j < 2; j++)
					{
						var proj:Projectile = this.projectiles.getProjectile(x + i, y + j);
						
						if (proj)
							this.flow.dispatchUpdate(Update.denyProjectile, proj);
					}
			}
			
			return CheckpointMasterBase.ILLEGAL_CELL;
		}
		
		override protected function activateCheckpoint(place:ICoordinated):void 
		{
			throw new Error("design undefined");
			
			//TODO: empower checkpoints, make them more meaningful
		}
	}

}