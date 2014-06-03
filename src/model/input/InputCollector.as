package model.input 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.metric.DCellXY;
	import starling.events.Event;
	import structs.InputPiece;
	
	internal class InputCollector
	{
		private const NO_DIRECTION:int = 0;
		
		private var maxI:int;
		
		internal var order:Vector.<int>;
		internal var actions:Vector.<Boolean>;
		
		public function InputCollector(binder:IBinder) 
		{
			binder.eventDispatcher.addEventListener(GlobalEvent.DEACTIVATED, 
			                                        this.clearInput);
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.clearInput);
			binder.eventDispatcher.addEventListener(GlobalEvent.ACTIVATE_GAME_SCREEN,
			                                        this.clearInput);
			binder.eventDispatcher.addEventListener(GlobalEvent.ADD_INPUT_PIECE,
			                                        this.newInputPiece);
			binder.eventDispatcher.addEventListener(GlobalEvent.PERFORM_ACTION,
			                                        this.actionRequested);
			
			this.actions = new Vector.<Boolean>(Game.NUMBER_OF_ACTIONS, true);
			for (var i:int = 0; i < Game.NUMBER_OF_ACTIONS; i++)
				this.actions[i] = false;
			
			
			
			this.order = new Vector.<int>(17, true);
			this.order[this.NO_DIRECTION] = 0;
		}
		
		private function newInputPiece(event:Event, input:InputPiece):void
		{	
			var tmp:int = 0;
			
			//tmp += isKeyboard ? this.KEYBOARD : this.MOUSE;
			tmp += Input.KEYBOARD;
			tmp += this.dCXYtoInt(input.change);
			
			if (input.isOn)
			{
				this.bubble(tmp + Input.PRESS);
				this.bubble(tmp + Input.CLICK); 
			}
			else
			{
				this.pop(tmp + Input.PRESS);
			}
		}
		
		private function actionRequested(event:Event, action:int):void
		{
			this.actions[action] = true;
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