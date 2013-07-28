package ui.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.utils.SaveBase;

	public class SaveFormStatistics extends SaveBase
	{
		public static const toggleRoll:String = "toggleRoll";
		public static const toggleFix:String = "toggleFix";
		
		private static const UNDETERMINED:int = -1;
		
		private var requester:ITakeSaveFormStatistics;
		private var title:String;
		
		private var flow:IUpdateDispatcher;
		
		public function SaveFormStatistics(requester:ITakeSaveFormStatistics, flow:IUpdateDispatcher) 
		{
			this.requester = requester;
			this.title = this.requester.title;
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(SaveFormStatistics.toggleRoll);
			this.flow.addUpdateListener(SaveFormStatistics.toggleFix);
			
			super();
		}
		
		override protected function checkLocalSave():void
		{
			var number:int;
			var roll:Boolean;
			var fix:Boolean;
			
			if (this.localSave.data[this.title] == null)
			{		
				this.localSave.data[this.title] = new Object();
				this.localSave.data[this.title].number = SaveFormStatistics.UNDETERMINED;
				this.localSave.data[this.title].roll = false;
				this.localSave.data[this.title].fix = false;
			}
			
			number = this.localSave.data[this.title].number;
			roll = this.localSave.data[this.title].roll;
			fix = this.localSave.data[this.title].fix;
			
			this.requester.takeSave(number, roll, fix);
		}
		
		update function toggleRoll(requesterTitle:String):void 
		{
			if(requesterTitle == this.title)
				this.localSave.data[this.title].roll = !this.localSave.data[this.title].roll;
		}
		
		update function toggleFix(requesterTitle:String):void 
		{
			if(requesterTitle == this.title)
				this.localSave.data[this.title].fix = !this.localSave.data[this.title].fix;
		}
		
	}

}