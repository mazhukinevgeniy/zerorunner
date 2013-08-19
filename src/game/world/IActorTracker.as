package game.world 
{
	import game.utils.metric.DCellXY;
	import game.world.broods.ItemLogicBase;
	
	public interface IActorTracker 
	{
		function addActor(item:ItemLogicBase):void;
		/*{
			this.putActorInCell(item.x, item.y, item);
		}*/
		
		function moveActor(actor:ItemLogicBase, change:DCellXY, delay:int):void;
		/*{
			this.putActorInCell(actor.x - change.x, actor.y - change.y);
			this.putActorInCell(actor.x, actor.y, actor);
		}*/
		
		function removeActor(actor:ItemLogicBase):void;
		/*{
			this.putActorInCell(actor.x, actor.y);
		}*/
		//TODO: implement
	}
	
}