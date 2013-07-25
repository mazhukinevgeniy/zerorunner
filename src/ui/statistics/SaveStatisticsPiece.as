package ui.statistics 
{
	import chaotic.utils.SaveBase;
	/**
	 * ...
	 * @author 
	 */
	public class SaveStatisticsPiece extends SaveBase
	{
		
		private var id:String;
		private var title:String;
		private var parent:ChunkList;
		
		public function SaveStatisticsPiece(id:int, title:String, parent:ChunkList) 
		{
			super();
			
			this.id = String(id);
			this.title = title;
			this.parent = parent;
		}
		
		override protected function checkLocalSave():void
		{
			if (this.localSave.data.statistics == null)
			{
				this.localSave.data.statistics.piece[this.id] = new Object();
				this.localSave.data.statistics.piece[this.id].title = this.title;
				this.localSave.data.statistics.piece[this.id].roll = false;
				this.localSave.data.statistics.piece[this.id].fix = false;
			}
			
			if (this.localSave.data.statistics.piece[this.id].roll)
				this.parent.handleRollButtonTriggered();
				
			if (this.localSave.data.statistics.piece[this.id].fix)
				this.parent.handleFixButtonTriggered();
		}
		
		public function toggleRoll():void
		{
			this.localSave.data.statistics.piece[this.id].roll = !this.localSave.data.statistics.piece[this.id].roll;
		}
		
		public function toggleFix():void
		{
			this.localSave.data.statistics.piece[this.id].fix = !this.localSave.data.statistics.piece[this.id].fix;
		}
		
	}

}