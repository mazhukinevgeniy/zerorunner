package model.items.concrete 
{
	import binding.IBinder;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	
	internal class BeaconMaster extends MasterBase
	{
		private var tmpCell:CellXY;
		
		public function BeaconMaster(binder:IBinder, items:Items) 
		{
			super(binder, items);
			
			this.tmpCell = new CellXY(0, 0);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.tmpCell.setValue(x, y);
			
			new Beacon(this, this.tmpCell);
		}
	}

}