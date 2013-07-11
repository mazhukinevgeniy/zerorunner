package game.actors.manipulator.actions 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.ActorsFeature;
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import game.metric.DCellXY;
	
	public class Bite
	{
		private var actors:ISearcher;
		private var flow:IUpdateDispatcher;
		
		private const DAMAGE:int = 5;
		
		public function Bite(flow:IUpdateDispatcher, actors:ISearcher) 
		{
			this.flow = flow;
			this.actors = actors;
		}
		
		
		public function act(item:Puppet, change:DCellXY):void
		{
			var target:Puppet = this.actors.findObjectByCell((item.getCell()).applyChanges(change));
			
			this.flow.dispatchUpdate(ActorsFeature.damageActor, target, this.DAMAGE);
		}
	}

}