package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.utils.SaveBase;

	public class FormChunkStatistics extends SaveBase
	{
		public static const toggleRoll:String = "toggleRoll";
		public static const toggleFix:String = "toggleFix";
		
		private static const UNDETERMINED:int = -1;
		
		private var chunk:ITakeSaveForm;
		private var chunkTitle:String;
		
		private var flow:IUpdateDispatcher;
		
		public function FormChunkStatistics(chunk:ITakeSaveForm, flow:IUpdateDispatcher) 
		{
			this.chunk = chunk;
			this.chunkTitle = this.chunk.title;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(FormChunkStatistics.toggleRoll);
			this.flow.addUpdateListener(FormChunkStatistics.toggleFix);
			
			super();
		}
		
		override protected function checkLocalSave():void
		{
			var order:int;
			var isRoll:Boolean;
			var isFix:Boolean;
			
			if (this.localSave.data[this.chunkTitle] == null)
			{		
				this.localSave.data[this.chunkTitle] = new Object();
				this.localSave.data[this.chunkTitle].order = FormChunkStatistics.UNDETERMINED;
				this.localSave.data[this.chunkTitle].isRoll = false;
				this.localSave.data[this.chunkTitle].isFix = false;
			}
			
			order = this.localSave.data[this.chunkTitle].order;
			isRoll = this.localSave.data[this.chunkTitle].isRoll;
			isFix = this.localSave.data[this.chunkTitle].isFix;
			
			this.chunk.takeSave(order, isRoll, isFix);
		}
		
		update function toggleRoll(requesterTitle:String):void 
		{
			if(requesterTitle == this.chunkTitle)
				this.localSave.data[this.chunkTitle].isRoll = !this.localSave.data[this.chunkTitle].isRoll;
		}
		
		update function toggleFix(requesterTitle:String):void 
		{
			if(requesterTitle == this..chunkTitle)
				this.localSave.data[this..chunkTitle].isFix = !this.localSave.data[this.chunkTitle].isFix;
		}
		
	}

}