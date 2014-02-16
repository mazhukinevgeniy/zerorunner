package game.core.input
{
	import data.viewers.GameConfig;
	import flash.events.Event;
	import game.core.metric.DCellXY;
	import game.core.metric.ProtectedDCellXY;
	import starling.core.Starling;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class InputManager
	{
		private var changes:Vector.<DCellXY>;
		
		private var order:Vector.<int>;
		private var maxI:int;
		
		private var _isSpacePressed:Boolean;
		
		public function InputManager(flow:IUpdateDispatcher)
		{
			super();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
			
			Starling.current.nativeStage.addEventListener(Event.DEACTIVATE, this.handleDeactivation);
			
			this.changes = new Vector.<DCellXY>(5, true);
			
			for (var i:int = 0; i < 5; i++)
			{
				this.changes[i] = new ProtectedDCellXY(	i == 1 ? 1 : i == 3 ? -1 : 0,
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
			
			this._isSpacePressed = false;
		}
		
		update function restore(config:GameConfig):void
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
			
			for (i = 9; i < 17; i++)
				this.order[i] = -1;
			
			return arr;
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
		
		internal function spacePressed():void
		{
			this._isSpacePressed = true;
		}
		
		public function get isSpacePressed():Boolean
		{
			var tmp:Boolean = this._isSpacePressed;
			this._isSpacePressed = false;
			
			return tmp;
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