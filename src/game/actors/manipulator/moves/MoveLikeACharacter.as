package game.actors.manipulator.moves 
{
	import game.actors.ActorsFeature;
	import game.actors.manipulator.actions.Kick;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import game.input.IKnowInput;
	import game.input.InputManager;
	import game.metric.DCellXY;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	public class MoveLikeACharacter extends MoveBase
	{		
		private var landscape:IScene;
		private var input:IKnowInput;
		
		private var flow:IUpdateDispatcher;
		
		private var kick:Kick;
		
		public function MoveLikeACharacter(newLandscape:IScene, newInput:IKnowInput, flow:IUpdateDispatcher, kick:Kick) 
		{
			this.landscape = newLandscape;
			this.input = newInput;
			
			this.flow = flow;
			
			this.kick = kick;
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
		
		override protected function afterMoved(item:Puppet):void
		{
			this.flow.dispatchUpdate(InputManager.purgeClicks);
		}
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.kick.act(item, change);
		}
	}

}