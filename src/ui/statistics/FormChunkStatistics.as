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
			
			if (this.localSave.data.statistics == null)
			{		
				this.createStatisticsSave();
			}
			
			if (this.localSave.data.statistics[this.chunkTitle] == null)
			{	
				this.createNewSave();	
			}
			
			this.readSave();
		}
		
		private function createStatisticsSave():void
		{
			this.localSave.data.statistics = new Object();
		}
		
		private function createNewSave():void
		{
			this.localSave.data.statistics[this.chunkTitle] = new Object();
			this.localSave.data.statistics[this.chunkTitle].order = FormChunkStatistics.UNDETERMINED;
			this.localSave.data.statistics[this.chunkTitle].isRoll = false;
			this.localSave.data.statistics[this.chunkTitle].isFix = false;
		}
		
		private function readSave():void
		{
			this.saveOrder = this.localSave.data.statistics[this.chunkTitle].order;
			this.saveIsRoll = this.localSave.data.statistics[this.chunkTitle].isRoll;
			this.saveIsFix = this.localSave.data.statistics[this.chunkTitle].isFix;
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
			this.localSave.data.statistics[this.chunkTitle].isRoll = newIsRoll;
		}
		
		public function set isFix(newIsFix:Boolean):void 
		{
			this.localSave.data.statistics[this.chunkTitle].isFix = newIsFix
		}
		
		public function set order(newOrder:int):void
		{
			this.localSave.data.statistics[this.chunkTitle].order = newOrder;
		}
		
	}

}