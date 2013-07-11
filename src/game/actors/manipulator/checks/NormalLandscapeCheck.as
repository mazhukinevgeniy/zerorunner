package game.actors.manipulator.checks 
{
	import game.actors.ActorsFeature;
	import game.actors.storage.Puppet;
	import game.scene.IScene;
	import game.scene.SceneFeature;
	
	public class NormalLandscapeCheck extends CheckBase
	{
		private var landscape:IScene;
		
		public function NormalLandscapeCheck(newLandscape:IScene)
		{
			this.landscape = newLandscape;
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (this.landscape.getSceneCell(item.getCell()) == SceneFeature.FALL)
			{
				this.damageActor(item, ActorsFeature.MAXIMUM_DAMAGE);
			}
		}
		
	}

}