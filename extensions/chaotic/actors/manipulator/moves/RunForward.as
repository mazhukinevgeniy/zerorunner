package chaotic.actors.manipulator.moves 
{
	import chaotic.actors.manipulator.actions.Bite;
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	
	public class RunForward extends MoveBase
	{
		private var scene:IScene;
		
		private var forward:DCellXY = new DCellXY(1, 0);
		private var jump:DCellXY = new DCellXY(2, 0);
		
		private var bite:Bite;
		
		public function RunForward(newPerformer:IActionPerformer, searcher:ISearcher, scene:IScene, bite:Bite) 
		{
			this.bite = bite;
			
			this.searcher = searcher;
			
			this.performer = newPerformer;
			this.scene = scene;
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			var cell:CellXY = item.getCell();
			
			if (this.scene.getSceneCell(new CellXY(cell.x + 1, cell.y)) != SceneFeature.FALL)
				this.callMove(item, this.forward);
			else
				this.performer.jumpedActor(item, this.jump);
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.bite.act(item, change);
		}
	}

}