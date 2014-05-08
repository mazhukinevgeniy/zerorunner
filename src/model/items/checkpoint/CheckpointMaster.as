package model.items.checkpoint 
{
	import binding.IBinder;
	import model.interfaces.IProjectiles;
	import model.items._utils.CheckpointMasterBase;
	import model.items.Items;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	
	public class CheckpointMaster extends CheckpointMasterBase
	{
		private var projectiles:IProjectiles;
		private var projectileController:ProjectileController;
		
		private var checkpoints:Vector.<Checkpoint>;
		
		public function CheckpointMaster(binder:IBinder, items:Items) 
		{			
			super(elements);
			
			this.checkpoints = new Vector.<Checkpoint>();
			
			this.projectiles = elements.projectiles;
			this.projectileController = elements.projectileController;
			
		}
		
		override protected function onGameFinished():void 
		{
			this.checkpoints.length = 0;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			if (!this.projectiles)
				this.projectiles = elements.projectiles;
			
			this.checkpoints.push(
				new Checkpoint(this, this.elements, new CellXY(x, y)));
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
							this.projectileController.denyProjectile(proj);
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