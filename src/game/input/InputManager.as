package game.input
{
	import data.viewers.GameConfig;
	import flash.events.Event;
	import game.metric.DCellXY;
	import game.metric.ProtectedDCellXY;
	import starling.core.Starling;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class InputManager implements IKnowInput
	{
		private const PRESS:int = 0;
		private const CLICK:int = 8;
		private const KEYBOARD:int = 0;
		private const MOUSE:int = 4;
		
		
		private var changes:Vector.<DCellXY>;
		
		private var order:Vector.<int>;
		private var maxI:int;
		
		private var _isSpacePressed:Boolean;
		
		public function InputManager(flow:IUpdateDispatcher)
		{
			super();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.newInputPiece);
			flow.addUpdateListener(Update.spacePressed);
			
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
				                  this.order[i + this.MOUSE],
				                  this.order[i + this.CLICK], 
								  this.order[i + this.CLICK + this.MOUSE])
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
		
		
		update function newInputPiece(isOn:Boolean, change:DCellXY):void
		{	
			var tmp:int = 0;
			
			//tmp += isKeyboard ? this.KEYBOARD : this.MOUSE;
			tmp += this.KEYBOARD;
			tmp += this.dCXYtoInt(change);
			
			if (isOn)
			{
				this.bubble(tmp + this.PRESS);
				this.bubble(tmp + this.CLICK); 
			}
			else
			{
				this.pop(tmp + this.PRESS);
			}
		}
		
		update function spacePressed():void
		{
			this._isSpacePressed = true;
		}
		
		public function get isSpacePressed():Boolean
		{
			var tmp:Boolean = this._isSpacePressed;
			this._isSpacePressed = false;
			//TODO: fix the logic: there must be clean /getting/ methods and, 
			//      not as the part of them, method that refreshes all the flags
			
			return tmp;
		}
		
		
		private static const NO_DIRECTION:int = 0;
		
		private function dCXYtoInt(item:DCellXY):int
		{
			return 2 * item.x * item.x - item.x + 3 * item.y * item.y - item.y;
		}
		
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