package game.actors.manipulator.moves 
{
	import game.actors.storage.Puppet;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	public class SearchCorridor extends MoveBase
	{
		private var scene:IScene;
		
		public function SearchCorridor(newScene:IScene) 
		{
			this.scene = newScene;
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			var data:Object = (item.data.searchCorridor = new Object());
			
			data.isFixed = new Boolean(false);
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			var data:Object = item.data.searchCorridor;
			
			if (!data.isFixed)
			{
				var x:int = item.x;
				var y:int = item.y;
				
				var fall:int = SceneFeature.FALL;
				
				var left:int = this.scene.getSceneCell(new CellXY(x - 1, y)),
					right:int = this.scene.getSceneCell(new CellXY(x + 1, y)),
					up:int = this.scene.getSceneCell(new CellXY(x , y - 1)),
					down:int = this.scene.getSceneCell(new CellXY(x, y + 1));
				
				if ((left != fall || right != fall)
					&&
					(up != fall || down != fall)
				   )
				{
					var move:DCellXY = Metric.getRandomDCell();
					
					if (this.scene.getSceneCell(item.getCell().applyChanges(move)) != fall)
					{
						this.callMove(item, move);
					}
				}
				else data.isFixed = true;
			}
		}
		
	}

}