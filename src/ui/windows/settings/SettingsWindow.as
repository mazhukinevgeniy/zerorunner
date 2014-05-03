package ui.windows.settings 
{
	import data.Preferences;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;

	public class SettingsWindow extends Window
	{
		
		public function SettingsWindow(flow:IUpdateDispatcher, preferences:Preferences)
		{
			this.addChild(new MuteButton(flow, preferences));
		}
		
	}

}