package chaotic.grinder 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.informers.IStoreInformers;
	import chaotic.metric.CellXY;
	import chaotic.updates.IGrinderAdder;
	import chaotic.updates.IInformerAdder;
	import chaotic.updates.IRestorable;
	
	internal class Grinders extends ChaoticFeature implements IGrinderAdder, IRestorable, IInformerAdder, IGrinder
	{
		private var topLine:int;
		
		private var streams:Vector.<GrindingStream>;
		
		
		public function Grinders() 
		{
			
		}
		
		public function addGrinders(vector:Vector.<GrindingStream>):void
		{
			this.streams = vector;
		}
		
		public function restore():void
		{
			this.topLine = 0;
		}
		
		
		public function isGrinded(cell:CellXY):Boolean
		{
			return this.getFront(cell.y) >= cell.x;
		}
		
		public function getFront(y:int):int
		{
			var line:int = y - this.topLine;
			while (line < 0) line += GrinderFeature.HEIGHT * GrinderFeature.NUMBER;
			
			var stream:int = (line / GrinderFeature.HEIGHT) % GrinderFeature.NUMBER;
			
			return this.streams[stream].front;
		}
		
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IGrinder, this);
		}
	}

}