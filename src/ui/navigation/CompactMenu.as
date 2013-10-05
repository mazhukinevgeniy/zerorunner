package ui.navigation 
{
	import feathers.layout.VerticalLayout;
	import starling.events.Event;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;

	public class CompactMenu extends MainMenu
	{
		
		public function CompactMenu(flow:IUpdateDispatcher) 
		{
			super(flow);
			
			this.visible = true;
		}
		
		override protected function initializeSize():void 
		{
			
		}
		
		override protected function initializeLayout():void 
		{
			var layout:VerticalLayout = new VerticalLayout();
			this.layout = layout;
		}
		
		override protected function initializeButtons():void 
		{
			this.playButton = ButtonMenuFactory.create("P", true);
			this.addChild(this.playButton);
			
			this.statisticsButton = ButtonMenuFactory.create("S", true);
			this.addChild(this.statisticsButton);
			
			this.creditsButton = ButtonMenuFactory.create("C", true);
			this.addChild(this.creditsButton);
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.statisticsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
		}
		
	}

}