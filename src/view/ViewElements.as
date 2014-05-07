package view 
{
	import binding.IBinder;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	
	public class ViewElements 
	{
		
		public function ViewElements(binder:IBinder, root:DisplayObjectContainer) 
		{
			var shellRoot:Sprite = new Sprite();
			var gameRoot:Sprite = new Sprite();
			
			root.addChild(shellRoot);
			root.addChild(gameRoot);
			
			gameRoot.visible = false;
			
			
			
		}
		
	}

}