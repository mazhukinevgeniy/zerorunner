package game.items.character 
{
	import game.core.input.InputManager;
	import game.core.metric.CellXY;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.Items;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import utils.updates.IUpdateDispatcher;
	
	
	internal class Character extends PuppetBase
	{
				
		private var input:InputManager;
		private var flow:IUpdateDispatcher;
		private var points:IPointCollector;
		private var scene:IScene;
		
		public function Character(master:MasterBase, elements:GameElements) 
		{
			this.input = elements.input;
			this.flow = elements.flow;
			this.items = elements.items;
			this.scene = elements.scene;
			
			var cell:CellXY = new CellXY
					(Game.BORDER_WIDTH, 
					 Game.BORDER_WIDTH + elements.database.config.width - 1);
			
			super(master, elements, cell);
			
			this.points = elements.pointsOfInterest;
			
			this.flow.dispatchUpdate(Update.setCenter, this);
		}
		
		/*
		override internal function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}*///TODO: move to the occupation (because dying is business too)
		
		
		
		/*override items_internal function move(change:DCellXY):void
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
		}*/
		
	}

}