package view.shell.screens 
{
	import binding.IBinder;
	import feathers.controls.ScrollContainer;
	import view.shell.WindowBase;
	
	public class AchievementsWindow extends WindowBase
	{	
		//TODO: the plan is to have, like, a road of achievements.
		// a road which is forked in many places.
		// like, a tree.
		
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
	//TODO: rename class

}