package game.actors.manipulator.actions 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.ActorsFeature;
	import game.actors.manipulator.ActionBase;
	import game.actors.storage.Puppet;
	import game.metric.DCellXY;
	
	public class Bite extends ActionBase
	{
		private const DAMAGE:int = 5;
		
		public function Bite() 
		{
			
		}
		
		
		public function act(item:Puppet, change:DCellXY):void
		{
			var target:Puppet = this.searcher.findObjectByCell((item.getCell()).applyChanges(change));
			
			this.damageActor(target, this.DAMAGE);
		}
	}

}