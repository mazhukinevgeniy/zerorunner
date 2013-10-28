package game.items.character 
{
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import game.items.items_internal;
	import utils.updates.IUpdateDispatcher;
	
	use namespace items_internal;
	
	internal class Existence extends ExistenceCore
	{
		private const MOVE_SPEED:int = 1;
		
		override items_internal function move(change:DCellXY):void
		{
			var delay:int = this.MOVE_SPEED;
			
			if (!this.items.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				super.move(change);
				
				this.item.cooldown = delay;
				//TODO: something is broken, broken to the core, infection is growing, pulled until it's tore!
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
		}
		
		items_internal function jump(change:DCellXY, multiplier:int):void
		{
			var obstacles:int = 0;
			
			for (var i:int = 0; i < multiplier; i++)
				if (this.items.findObjectByCell(this.x + (i + 1) * change.x, this.y + (i + 1) * change.y))
					return;
			
			change.setValue(change.x * multiplier, change.y * multiplier);
			
			super.move(change);
			this.item.cooldown = this.MOVE_SPEED * 2 * multiplier;
			
			this.flow.dispatchUpdate(Update.moveCenter, change, this.item.cooldown + 1);
			//TODO: animate
		}
		
		override items_internal function moveTo(goal:ICoordinated):void
		{
			throw new Error();
		}
		
		
		override items_internal function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
	}

}