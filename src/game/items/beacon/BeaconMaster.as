package game.items.beacon 
{
	import game.GameElements;
	import game.items.Items;
	import game.items.MasterBase;
	import game.metric.CellXY;
	import game.scene.IScene;
	
	public class BeaconMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function BeaconMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			super(elements);
		}
		
		override protected function gameStarted():void 
		{
			var cell:CellXY = new CellXY(0, 0);
			var items:Items = this.elements.items;
			var scene:IScene = this.elements.scene;
			
			for (var i:int = 0; i < Game.MAP_WIDTH; i++)
				for (var j:int = 0; j < Game.MAP_WIDTH; j++)
					if (Math.random() < 0.1 && scene.getSceneCell(i, j) == Game.SCENE_GROUND && !items.findAnyObjectByCell(i, j))
					{
						cell.setValue(i, j);
						
						new Beacon(this, this.elements, cell);
					}
		}
	}

}