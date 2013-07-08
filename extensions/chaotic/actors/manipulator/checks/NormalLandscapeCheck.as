package chaotic.actors.manipulator.checks 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.scene.IScene;
	import chaotic.scene.SceneFeature;
	
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