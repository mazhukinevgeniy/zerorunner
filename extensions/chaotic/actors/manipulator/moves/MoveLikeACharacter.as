package chaotic.actors.manipulator.moves 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.input.IKnowInput;
	import chaotic.input.InputManager;
	import chaotic.metric.DCellXY;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	
	public class MoveLikeACharacter extends MoveBase
	{		
		private var landscape:IScene;
		private var input:IKnowInput;
		
		private var flow:IUpdateDispatcher;
		
		public function MoveLikeACharacter(newLandscape:IScene, newInput:IKnowInput, newPerformer:IActionPerformer, newSearcher:ISearcher, flow:IUpdateDispatcher) 
		{
			this.searcher = newSearcher;
			
			this.performer = newPerformer;
			
			this.landscape = newLandscape;
			this.input = newInput;
			
			this.flow = flow;
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
					this.callMove(item, action);
					
					return;
				}
				
				action = tmp.pop();
			}
		}
		
		override protected function onMoved(item:Puppet, change:DCellXY):void
		{
			super.onMoved(item, change);
			
			this.flow.dispatchUpdate(InputManager.purgeClicks);
		}
	}

}