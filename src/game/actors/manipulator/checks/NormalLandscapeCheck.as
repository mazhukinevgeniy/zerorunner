package game.actors.manipulator.checks 
{
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	public class NormalLandscapeCheck extends CheckBase
	{
		private var landscape:IScene;
		
		public function NormalLandscapeCheck(newLandscape:IScene, newPerformer:IActionPerformer)
		{
			this.performer = newPerformer;
			this.landscape = newLandscape;
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (this.landscape.getSceneCell(item.getCell()) == SceneFeature.FALL)
			{
				this.performer.destroyActor(item);
			}
		}
		
	}

}