package model.items.concrete 
{
	import events.GlobalEvent;
	import model.interfaces.IInput;
	import model.interfaces.IItemSnapshotter;
	import model.interfaces.IScene;
	import model.items.ItemBase;
	import model.items.structs.ItemParams;
	import model.metric.DCellXY;
	import starling.events.EventDispatcher;
	import utils.getCellId;
	
	
	internal class Character extends ItemBase
	{
		private var dispatcher:EventDispatcher;
		
		private var input:IInput;
		private var scene:IScene;
		private var items:IItemSnapshotter;
		
		public function Character(params:ItemParams) 
		{
			this.dispatcher = params.binder.eventDispatcher;
			
			this.input = params.binder.input;
			this.scene = params.binder.scene;
			this.items = params.binder.itemSnapshotter;
			
			super(params);
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
					
					if (this.canStandOn(next))
					{
						this.startMovingBy(action);
						
						break;
					}
				}
				
				action = tmp.pop();
			}
			
			if (!this.canStandOn(this.scene.getSceneCell(getCellId(this.x, this.y))))
			{
				this.die();
			}
		}
		
		override public function get type():int { return Game.ITEM_CHARACTER; }
		
		override protected function get isActive():Boolean 
		{
			return true;
		}
		
		override protected function onUnstabilized():void 
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.GAME_STOPPED,
											  false,
											  Game.ENDING_LOST);
		}
		
		
		private function canStandOn(cellType:int):Boolean
		{
			return cellType == Game.SCENE_GROUND || cellType == Game.SCENE_BRIDGE;
		}
	}

}