package chaotic.input
{
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.DCellXY;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	import chaotic.xml.getActorsXML;
	
	public class InputManager implements IUpdateListener, IKnowInput
	{
		private var order:Vector.<int>;
		private var maxI:int;
		
		public function InputManager()
		{
			super();
			
			this.restore();
		}
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "movedLikeACharacter");
			storage.addUpdateListener(this, "restore");
			storage.addUpdateListener(this, "newInputPiece");
			storage.addUpdateListener(this, "addInformerTo");
		}
		
		public function movedLikeACharacter(number:int):void
 		{
			if (number == 0)
				for (var i:int = 9; i < 17; i++)
					this.order[i] = -1;
 		}
		
		public function getInputCopy():Vector.<DCellXY>
		{
			var arr:Vector.<DCellXY> = new Vector.<DCellXY>(5);
			var vals:Vector.<int> = new Vector.<int>(5, true);
			
			arr[0] = this.intToDXY(0);
			vals[0] = this.order[0];
			for (var i:int = 1; i < 5; i++)
			{
				arr[i] = this.intToDXY(i);
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
		
		public function restore():void
		{
			this.order = new Vector.<int>(17, true);
			this.order[InputManager.NO_DIRECTION] = 0;
			
			this.maxI = 1;
			
			for (var i:int = 1; i < 17; i++) 
				this.order[i] = -1;
		}
		
		public function newInputPiece(item:InputPiece):void
		{	
			var tmp:int = 0;
			
			tmp += item.isKeyboard ? InputManager.KEYBOARD : InputManager.MOUSE;
			tmp += this.dCXYtoInt(item.change);
			
			if (item.isOn)
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
		private function intToDXY(value:int):DCellXY
		{
			return new DCellXY(value == 1 ? 1 : value == 3 ? -1 : 0,
							   value == 2 ? 1 : value == 4 ? -1 : 0);
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
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IKnowInput, this);
		}
	}

}