package view 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.INotifier;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	public class ViewElements implements IDependent
	{
		
		public function ViewElements(binder:IBinder, root:DisplayObjectContainer) 
		{
			var shellRoot:Sprite = new Sprite();
			var gameRoot:Sprite = new Sprite();
			
			root.addChild(shellRoot);
			root.addChild(gameRoot);
			
			gameRoot.visible = false;
			
			binder.requestBindingFor(this);
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var notifier:INotifier = binder.notifier;
			
			//TODO: observe newGame/quitGame
		}
	}

}