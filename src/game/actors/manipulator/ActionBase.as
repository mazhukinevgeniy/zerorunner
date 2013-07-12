package game.actors.manipulator 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.ActorsFeature;
	import game.actors.storage.ISearcher;
	import game.actors.storage.Puppet;
	import chaotic.errors.AbstractClassError;
	import game.metric.DCellXY;
	
	public class ActionBase
	{
		internal static var flow:IUpdateDispatcher;
		internal static var searcher:ISearcher;
		
		public function ActionBase() 
		{
			
		}
		
		public function actOn(item:Puppet, ... args):void
		{
			throw new AbstractClassError();
		}
		
		public function prepareDataIn(item:Puppet):void
		{
			throw new AbstractClassError();
		}
		
		protected function get searcher():ISearcher
		{
			return ActionBase.searcher;
		}
		
		final protected function damageActor(item:Puppet, damage:int):void
		{
			item.hp -= damage;
			
			ActionBase.flow.dispatchUpdate(ActorsFeature.actorDamaged, item, damage);
			
			if (!(item.hp > 0))
			{
				ActionBase.flow.dispatchUpdate(ActorsFeature.actorDestroyed, item);
			}
		}
		
		final protected function jumpActor(item:Puppet, change:DCellXY):void
		{
			item.remainingDelay = item.speed * change.length;
			
			var target:Puppet = ActionBase.searcher.findObjectByCell(item.getCell().applyChanges(change));
			if (target != null) ActionBase.flow.dispatchUpdate(ActorsFeature.actorDestroyed, target);
			
			ActionBase.flow.dispatchUpdate(ActorsFeature.actorMoved, item, change, item.remainingDelay + 1);
			ActionBase.flow.dispatchUpdate(ActorsFeature.actorJumped, item);
		}
		
		final protected function kick(kicker:Puppet, kicked:Puppet, change:DCellXY):void
		{
			/*
			if (target.remainingDelay / target.speed < 0.6)
				this.forceMove(target, change);
			else
			{
				//TODO: 
			}*/
		}
		
		final protected function callMove(item:Puppet, change:DCellXY):void
		{
			if (ActionBase.searcher.findObjectByCell(item.getCell().applyChanges(change)) == null)
			{
				this.onMoved(item, change);
			}
			else
				this.onBlocked(item, change);
		}
		
		private function onMoved(item:Puppet, change:DCellXY):void
		{
			item.remainingDelay = item.speed;
			var id:int = item.id;
			
			if (id == ActorsFeature.PROTAGONIST_ID)
				ActionBase.flow.dispatchUpdate(ActorsFeature.moveCenter, change, item.speed + 1);
			
			ActionBase.flow.dispatchUpdate(ActorsFeature.actorMoved, item, change, item.remainingDelay + 1);
			
			this.afterMoved(item);
		}
		
		protected function afterMoved(item:Puppet):void
		{
			
		}
		
		protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			
		}
	}

}