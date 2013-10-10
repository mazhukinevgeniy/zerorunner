package game.core.input
{
	import flash.events.Event;
	import game.core.metric.DCellXY;
	import starling.core.Starling;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class InputManager
	{
		
		private var order:Vector.<int>;
		private var maxI:int;
		
		private var changes:Vector.<DCellXY>;
		
		public function InputManager(flow:IUpdateDispatcher)
		{
			super();
			
			new KeyboardControls(this);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			
			Starling.current.nativeStage.addEventListener(Event.DEACTIVATE, this.handleDeactivation);
			
			this.changes = new Vector.<DCellXY>(5, true);
			
			for (var i:int = 0; i < 5; i++)
			{
				this.changes[i] = new DCellXY(	i == 1 ? 1 : i == 3 ? -1 : 0,
												i == 2 ? 1 : i == 4 ? -1 : 0);
			}
			
			this.order = new Vector.<int>(17, true);
			this.order[InputManager.NO_DIRECTION] = 0;
		}
		
		private function handleDeactivation(event:Event = null):void
		{
			for (var i:int = 1; i < 17; i++)
				this.order[i] = -1;
			
			this.maxI = 1;
		}
		
		update function prerestore():void
		{
			this.handleDeactivation();
		}
		
		public function getInputCopy():Vector.<DCellXY>
		{
			var arr:Vector.<DCellXY> = new Vector.<DCellXY>(5);
			var vals:Vector.<int> = new Vector.<int>(5, true);
			
			arr[0] = this.changes[0];
			vals[0] = this.order[0];
			for (var i:int = 1; i < 5; i++)
			{
				arr[i] = this.changes[i];
				vals[i] = Math.max(this.order[i], 
				                  this.order[i + InputManager.MOUSE],
				                  this.order[i + InputManager.CLICK], 
								  this.order[i + InputManager.CLICK + InputManager.MOUSE])
			}
			for (i = 0; i < 4; i++)
				for (var j:int = i + 1; j < 5; j++)
					if (vals[i] > vals[j])
						swap(i, j);
			
			var tmpi:int;
			var tmpd:DCellXY;
			function swap(pos1:int, pos2:int):void
			{
				tmpi = vals[pos1];
				tmpd = arr[pos1];
				
				vals[pos1] = vals[pos2];
				arr[pos1] = arr[pos2];
				
				vals[pos2] = tmpi;
				arr[pos2] = tmpd;
			}
			
			CONFIG::debug
			{
				trace("used", this.maxI, "of", int.MAX_VALUE);
			}
			
			return arr;
		}
		
		public function discardClicks():void
		{
			for (var i:int = 9; i < 17; i++)
				this.order[i] = -1;
		}
		
		
		internal function newInputPiece(isKeyboard:Boolean, isOn:Boolean, change:DCellXY):void
		{	
			var tmp:int = 0;
			
			tmp += isKeyboard ? InputManager.KEYBOARD : InputManager.MOUSE;
			tmp += this.dCXYtoInt(change);
			
			if (isOn)
			{
				this.bubble(tmp + InputManager.PRESS);
				this.bubble(tmp + InputManager.CLICK); 
			}
			else
			{
				this.pop(tmp + InputManager.PRESS);
			}
		}
		
		private static const NO_DIRECTION:int = 0;
		
		private function dCXYtoInt(item:DCellXY):int
		{
			return 2 * item.x * item.x - item.x + 3 * item.y * item.y - item.y;
		}
		
		private static const PRESS:int = 0;
		private static const CLICK:int = 8;
		private static const KEYBOARD:int = 0;
		private static const MOUSE:int = 4;
		
		private function bubble(value:int):void
		{
			this.order[value] = this.maxI;
			this.maxI++;
		}
		private function pop(value:int):void
		{
			this.order[value] = -1;
		}
	}

}