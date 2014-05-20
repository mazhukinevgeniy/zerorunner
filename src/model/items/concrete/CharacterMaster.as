package model.items.concrete 
{
	import binding.IBinder;
	import model.items.ItemBase;
	import model.items.Items;
	import model.items.MasterBase;
	import model.metric.CellXY;
	import model.metric.DCellXY;
	import model.status.StatusReporter;
	
	internal class CharacterMaster extends MasterBase
	{
		private var status:StatusReporter;
		
		public function CharacterMaster(binder:IBinder, items:Items, status:StatusReporter) 
		{
			super(binder, items);
			
			this.status = status;
		}
		
		override public function spawnPuppet(x:int, y:int):void 
		{
			var hero:ItemBase = new Character(this, new CellXY(x, y), this._binder);
			
			this.status.newHero(hero);
			this.addActor(hero);
		}
	}

}