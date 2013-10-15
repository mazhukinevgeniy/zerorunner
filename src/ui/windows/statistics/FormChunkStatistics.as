package ui.windows.statistics 
{

	public class FormChunkStatistics
	{		
		private static const UNDETERMINED:int = -1;
		
		private var chunkTitle:String;
		
		private var saveIsRoll:Boolean;
		private var saveIsFix:Boolean;
		
		public function FormChunkStatistics(chunkTitle:String) 
		{
			this.chunkTitle = chunkTitle;
			
			this.localSave.data.statistics[this.chunkTitle] = new Object();
			this.localSave.data.statistics[this.chunkTitle].isRoll = false;
			this.localSave.data.statistics[this.chunkTitle].isFix = false;
			
			this.saveIsRoll = this.localSave.data.statistics[this.chunkTitle].isRoll;
			this.saveIsFix = this.localSave.data.statistics[this.chunkTitle].isFix;
			
			
			//TODO: implement it as a... preference, i guess.
		}
		
		
		public function get isRoll():Boolean
		{
			return this.saveIsRoll;
		}
		
		public function set isRoll(newIsRoll:Boolean):void 
		{
			this.localSave.data.statistics[this.chunkTitle].isRoll = newIsRoll;
		}
		
		public function get isFix():Boolean
		{
			return this.saveIsFix;
		}
		
		public function set isFix(newIsFix:Boolean):void 
		{
			this.localSave.data.statistics[this.chunkTitle].isFix = newIsFix
		}
		
	}

}