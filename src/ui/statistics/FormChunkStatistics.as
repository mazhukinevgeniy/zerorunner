package ui.statistics 
{
	import chaotic.utils.SaveBase;

	public class FormChunkStatistics extends SaveBase
	{		
		private static const UNDETERMINED:int = -1;
		
		private var chunkTitle:String;
		
		private var saveOrder:int;
		private var saveIsRoll:Boolean;
		private var saveIsFix:Boolean;
		
		public function FormChunkStatistics(chunkTitle:String) 
		{
			this.chunkTitle = chunkTitle;
			
			super();
		}
		
		override protected function checkLocalSave():void
		{			
			if (this.localSave.data[this.chunkTitle] == null)
			{		
				this.localSave.data[this.chunkTitle] = new Object();
				this.localSave.data[this.chunkTitle].order = FormChunkStatistics.UNDETERMINED;
				this.localSave.data[this.chunkTitle].isRoll = false;
				this.localSave.data[this.chunkTitle].isFix = false;
			}
			
			this.saveOrder = this.localSave.data[this.chunkTitle].order;
			this.saveIsRoll = this.localSave.data[this.chunkTitle].isRoll;
			this.saveIsFix = this.localSave.data[this.chunkTitle].isFix;
		}
		
		public function get order():int
		{
			return this.saveOrder;
		}
		
		public function get isRoll():Boolean
		{
			return this.saveIsRoll;
		}
		
		public function get isFix():Boolean
		{
			return this.saveIsFix;
		}
		
		public function set isRoll(newIsRoll:Boolean):void 
		{
			this.localSave.data[this.chunkTitle].isRoll = newIsRoll;
		}
		
		public function set isFix(newIsFix:Boolean):void 
		{
			this.localSave.data[this.chunkTitle].isFix = newIsFix
		}
		
		public function set order(newOrder:int):void
		{
			this.localSave.data[this.chunkTitle].order = newOrder;
		}
		
	}

}