package model.input 
{
	import binding.IBinder;
	import controller.observers.activity.IDeactivationObserver;
	import controller.observers.game.IGameMenuRelated;
	import controller.observers.game.IInputObserver;
	import controller.observers.game.INewGameHandler;
	import controller.observers.map.IMapStatusObserver;
	import model.metric.DCellXY;
	
	internal class InputCollector implements IInputObserver,
	                                         INewGameHandler,
											 IMapStatusObserver,
											 IGameMenuRelated,
											 IDeactivationObserver
	{
		private const NO_DIRECTION:int = 0;
		
		private var maxI:int;
		
		internal var order:Vector.<int>;
		internal var actions:Vector.<Boolean>;
		
		public function InputCollector(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.actions = new Vector.<Boolean>(Game.NUMBER_OF_ACTIONS, true);
			for (var i:int = 0; i < Game.NUMBER_OF_ACTIONS; i++)
				this.actions[i] = false;
			
			
			
			this.order = new Vector.<int>(17, true);
			this.order[this.NO_DIRECTION] = 0;
		}
		
		public function newInputPiece(isOn:Boolean, change:DCellXY):void
		{	
			var tmp:int = 0;
			
			//tmp += isKeyboard ? this.KEYBOARD : this.MOUSE;
			tmp += Input.KEYBOARD;
			tmp += this.dCXYtoInt(change);
			
			if (isOn)
			{
				this.bubble(tmp + Input.PRESS);
				this.bubble(tmp + Input.CLICK); 
			}
			else
			{
				this.pop(tmp + Input.PRESS);
			}
		}
		
		public function actionRequested(action:int):void
		{
			this.actions[action] = true;
		}
		
		
		public function newGame():void
		{
			this.clearInput();
		}
		public function setVisibilityOfMap(visible:Boolean):void
		{
			this.clearInput();
		}
		public function setVisibilityOfMenu(visible:Boolean):void
		{
			this.clearInput();
		}
		public function processDeactivation():void
		{
			this.clearInput();
		}
		
		
		private function clearInput():void
		{
			for (var i:int = 1; i < 17; i++)
				this.order[i] = -1;
			
			this.maxI = 1;
			
			for (var j:int = 0; j < Game.NUMBER_OF_ACTIONS; j++)
				this.actions[j] = false;
		}
		
		
		
		private function bubble(value:int):void
		{
			this.order[value] = this.maxI;
			this.maxI++;
			
			if (this.maxI == int.MAX_VALUE)
				this.resetMaxI();
		}
		private function pop(value:int):void
		{
			this.order[value] = -1;
		}
		
		private function dCXYtoInt(item:DCellXY):int
		{
			return 2 * item.x * item.x - item.x + 3 * item.y * item.y - item.y;
		}
		
		
		private function resetMaxI():void
		{
			var values:Array = new Array();
			var positions:Array = new Array();
			
			for (var i:int = 1; i < 17; i++)
				if (this.order[i] > 0)
				{
					values.push(this.order[i]);
					positions[this.order[i]] = i;
				}
			
			values.sort(Array.NUMERIC);
			
			this.maxI = 1;
			
			for (var j:int = 0; j < values.length; j++)
			{
				this.order[positions[values[j]]] = this.maxI;
				
				this.maxI++;
			}
		}
	}

}