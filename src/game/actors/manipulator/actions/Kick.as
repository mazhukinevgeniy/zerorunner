package game.actors.manipulator.actions 
{
	import game.actors.ActorsFeature;
	import game.actors.manipulator.ActionBase;
	import game.actors.storage.Puppet;
	import game.metric.DCellXY;
	
	public class Kick extends ActionBase
	{
		private var check:ActionBase;
		
		public function Kick(landscapeCheck:ActionBase) 
		{
			this.check = landscapeCheck;
		}
		
		public function act(item:Puppet, change:DCellXY):void
		{
			var target:Puppet = this.searcher.findObjectByCell(item.getCell().applyChanges(change));
			this.callMove(target, change);
		}
		
		override protected function afterMoved(item:Puppet):void
		{
			this.check.actOn(item);
		}
		
		override protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			this.damageActor(item, ActorsFeature.MAXIMUM_DAMAGE);
		}
	}

}