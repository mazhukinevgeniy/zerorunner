package game.items.character 
{
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.cores.ExistenceCore;
	import game.items.Items;
	import game.items.items_internal;
	import utils.updates.IUpdateDispatcher;
	
	use namespace items_internal;
	
	internal class Existence extends ExistenceCore
	{
		private const MOVE_SPEED:int = 1;
		
		
		private var view:CharacterView;
		
		private var flow:IUpdateDispatcher;
		
		public function Existence(item:CharacterLogic, view:CharacterView, elements:GameElements) 
		{
			var cell:ICoordinated =
				Metric.getTmpCell(Game.BORDER_WIDTH, 
								  Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(item, elements, cell, this.MOVE_SPEED);
			
			this.view = view;
			this.flow = elements.flow;
		}
		
		override items_internal function move(change:DCellXY):void
		{
			var delay:int = this.MOVE_SPEED;
			
			if (!this.items.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				super.move(change);
				this.view.animateWalking(change, delay);
				
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
			
			var jChange:DCellXY = Metric.getTmpDCell(change.x * multiplier, change.y * multiplier);
			
			super.move(jChange);
			this.item.cooldown = this.MOVE_SPEED * 2 * multiplier;
			
			this.flow.dispatchUpdate(Update.moveCenter, jChange, this.item.cooldown + 1);
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