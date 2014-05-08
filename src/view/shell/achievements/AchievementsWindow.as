package view.shell.achievements 
{
	import binding.IBinder;
	import feathers.controls.ScrollContainer;
	import view.shell.WindowBase;
	
	public class AchievementsWindow extends WindowBase
	{	
		
		public function AchievementsWindow(binder:IBinder) 
		{
			super();
			
			this.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
			this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			//TODO: actually this is best done via the theme
			
			
		}
		
		public override function set visible(newValue:Boolean):void
		{
			if (newValue)
			{
				//TODO: move to the windowBase that ideology of "update if requested"
				
			}
			
			super.visible = newValue;
		}
	}

}