package model.input 
{
	import binding.IBinder;
	import model.interfaces.IInput;
	import model.metric.DCellXY;
	
	public class InputTeller implements IInput
	{
		private var changes:Vector.<DCellXY>;
		
		private var collector:InputCollector;
		
		
		public function InputTeller(binder:IBinder) 
		{
			this.collector = new InputCollector(binder);
			
			this.changes = new Vector.<DCellXY>(5, true);
			
			for (var i:int = 0; i < 5; i++)
			{
				this.changes[i] = new DCellXY(	i == 1 ? 1 : i == 3 ? -1 : 0,
												i == 2 ? 1 : i == 4 ? -1 : 0);
			}
		}
		
		public function getInputCopy():Vector.<DCellXY>
		{
			var arr:Vector.<DCellXY> = this.changes.slice(0, this.changes.length);
			var vals:Vector.<int> = new Vector.<int>(5, true);
			
			var order:Vector.<int> = this.collector.order;
			
			vals[0] = order[0];
			for (var i:int = 1; i < 5; i++)
			{
				vals[i] = Math.max(order[i], 
				                  order[i + Input.MOUSE],
				                  order[i + Input.CLICK], 
								  order[i + Input.CLICK + Input.MOUSE])
			}
			for (i = 0; i < 4; i++)
				for (var j:int = i + 1; j < 5; j++)
					if (vals[i] > vals[j])
					{
						var tmpi:int;
						var tmpd:DCellXY;
						
						tmpi = vals[i];
						tmpd = arr[i];
						
						vals[i] = vals[j];
						arr[i] = arr[j];
						
						vals[j] = tmpi;
						arr[j] = tmpd;
					}
			
			for (i = 9; i < 17; i++)
				order[i] = -1;
			
			return arr;
		}
		
		public function isThereInput():Boolean
		{
			var toReturn:Boolean;
			
			if (this.isActionRequested(Game.ACTION_SKIP_FRAME))
			{
				toReturn = true;
			}
			
			if (!toReturn)
				for (var i:int = 1; i < 17; i++)
					if (this.collector.order[i] > -1)
					{
						toReturn = true;
						break;
					}
			
			if (!toReturn)
				toReturn = this.collector.actions[Game.ACTION_FLIGHT];
			
			return toReturn;
		}
		
		public function isActionRequested(action:int):Boolean
		{
			var tmp:Boolean = this.collector.actions[action];
			this.collector.actions[action] = false;
			
			return tmp;
		}
	}

}