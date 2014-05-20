package model.items.concrete 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import model.interfaces.IInput;
	import model.interfaces.IItemSnapshotter;
	import model.interfaces.IScene;
	import model.items.ItemBase;
	import model.items.Items;
	import model.metric.DCellXY;
	import model.metric.ICoordinated;
	import utils.getCellId;
	import utils.isCellSolid;
	
	
	internal class Character extends ItemBase
	{
		private var gameController:IGameController;
		
		private var input:IInput;
		private var scene:IScene;
		private var items:IItemSnapshotter;
		
		public function Character(items:Items, binder:IBinder, cell:ICoordinated) 
		{
			this.gameController = binder.gameController;
			
			this.input = binder.input;
			this.scene = binder.scene;
			this.items = binder.itemSnapshotter;
			
			super(items, binder, cell);
		}
		
		override protected function act():void 
		{
			var tmp:Vector.<DCellXY> = this.input.getInputCopy();
			var action:DCellXY = tmp.pop();
			
			var x:int = this.x;
			var y:int = this.y;
			
			var next:int;
			
			while (action.x != 0 || action.y != 0)
			{
				var cellId:int = getCellId(x + action.x, y + action.y);
				
				if (!this.items.getItemSnapshot(cellId))
				{
					next = this.scene.getSceneCell(cellId);
					
					if (isCellSolid(next))
					{
						this.startMovingBy(action);
						
						break;
					}
				}
				
				action = tmp.pop();
			}
			
			if (!isCellSolid(this.scene.getSceneCell(getCellId(this.x, this.y))))
			{
				this.die();
			}
		}
		
		override protected function get movespeed():int { return 2; }
		override public function get type():int { return Game.ITEM_CHARACTER; }
		
		override protected function get isDestructible():Boolean 
		{
			return false;
		}
		
		override protected function get isActive():Boolean 
		{
			return true;
		}
		
		override protected function onUnstabilized():void 
		{
			this.gameController.gameStopped(Game.ENDING_LOST);
		}
	}

}