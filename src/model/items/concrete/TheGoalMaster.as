package model.items.concrete 
{
	import binding.IBinder;
	import model.interfaces.IStatus;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	import model.metric.ICoordinated;
	
	internal class TheGoalMaster extends MasterBase
	{
		private var currentGoal:TheGoal;
		
		private var status:IStatus;
		
		public function TheGoalMaster(binder:IBinder, items:Items) 
		{
			super(binder, items);
			
			this.status = binder.gameStatus;
		}
		//TODO: remove this, it's decorative
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			var cell:CellXY = new CellXY(x, y);
			
			this.currentGoal = new TheGoal(this, cell);
		}
	}

}