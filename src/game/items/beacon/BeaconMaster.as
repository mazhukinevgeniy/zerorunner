package game.items.beacon 
{
	import game.GameElements;
	import game.items.Items;
	import game.items.MasterBase;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class BeaconMaster extends MasterBase
	{
		private var tmpCell:CellXY;
		
		public function BeaconMaster(elements:GameElements) 
		{
			super(elements);
			
			this.tmpCell = new CellXY(0, 0);
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			this.tmpCell.setValue(x, y);
			
			new Beacon(this, this.elements, this.tmpCell);
		}
	}

}