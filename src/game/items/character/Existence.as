package game.items.character 
{
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.cores.ExistenceCore;
	import game.items.items_internal;
	
	use namespace items_internal;
	
	internal class Existence extends ExistenceCore
	{
		
		public function Existence(elements:GameElements) 
		{
			var cell:ICoordinated =
				Metric.getTmpCell(Game.BORDER_WIDTH, 
								  Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(elements, cell);
		}
		
		override items_internal function move(change:DCellXY, delay:int):void
		{
			var actor:ItemBase = this.actors.findObjectByCell(this.x + change.x, this.y + change.y);
			if (!actor)
			{
				super.move(change, delay);
				this.view.animateWalking(change, delay);
				
				this.cooldown = this.MOVE_SPEED;
				
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
		}
		
		override items_internal function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
	}

}