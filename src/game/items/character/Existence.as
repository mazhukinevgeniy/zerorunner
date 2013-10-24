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
		private var view:CharacterView;
		
		private var flow:IUpdateDispatcher;
		
		public function Existence(item:CharacterLogic, view:CharacterView, elements:GameElements) 
		{
			var cell:ICoordinated =
				Metric.getTmpCell(Game.BORDER_WIDTH, 
								  Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(item, elements, cell);
			
			this.view = view;
			this.flow = elements.flow;
		}
		
		override items_internal function move(change:DCellXY, delay:int):void
		{
			if (!this.items.findObjectByCell(this.x + change.x, this.y + change.y))
			{
				super.move(change, delay);
				this.view.animateWalking(change, delay);
				
				this.item.cooldown = delay;
				//TODO: something is broken, broken to the core, infection is growing, pulled until it's tore!
				this.flow.dispatchUpdate(Update.moveCenter, change, delay + 1);
				//TODO: animate
			}
		}
		
		override items_internal function moveTo(goal:ICoordinated, delay:int):void
		{
			throw new Error();
		}
		
		
		override items_internal function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
	}

}