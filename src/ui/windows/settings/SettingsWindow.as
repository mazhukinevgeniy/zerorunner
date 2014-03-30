package ui.windows.settings 
{
	import data.viewers.PreferencesViewer;
	import ui.windows.Window;
	import utils.updates.IUpdateDispatcher;

	public class SettingsWindow extends Window
	{
		
		public function SettingsWindow(flow:IUpdateDispatcher, preferences:PreferencesViewer)
		{
			this.addChild(new MuteButton(flow, preferences));
			this.addChild(new ResetButton(flow));
		}
		
	}

}