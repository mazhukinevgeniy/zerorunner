package chaotic.actors.manipulator.moves 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.input.IKnowInput;
	import chaotic.metric.DCellXY;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	
	public class MoveLikeACharacter extends MoveBase
	{		
		private var landscape:IScene;
		private var input:IKnowInput;
		
		public function MoveLikeACharacter(newLandscape:IScene, newInput:IKnowInput, newPerformer:IActionPerformer, newSearcher:ISearcher) 
		{
			this.searcher = newSearcher;
			
			this.performer = newPerformer;
			
			this.landscape = newLandscape;
			this.input = newInput;
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			while (action.x != 0 || action.y != 0)
			{
				if (this.landscape.getSceneCell(item.getCell().applyChanges(action)) != SceneFeature.FALL)
				{
					this.callMove(item, action, "movedLikeACharacter");
					
					return;
				}
				
				action = tmp.pop();
			}
		}
	}

}