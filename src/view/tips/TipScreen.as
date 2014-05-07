package view.tips 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import feathers.controls.Label;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class TipScreen extends Sprite
	{
		public static const showTip:String = "showTip";
		public static const hideTip:String = "hideTip";
		
		
		public static const DEVELOP:int = 0;
		
		
		private var tip:Label;
		
		private var tips:Vector.<String>;
		
		public function TipScreen(root:DisplayObjectContainer, flow:IUpdateDispatcher) 
		{
			var tips:Vector.<String> = new Vector.<String>();
			
			tips[TipScreen.DEVELOP] = "Добро пожаловать, славный разработчик!"
			
			
			
			
			
			this.tips = tips;
			
			
			
			
			super();
			
			this.addChild(new Quad(Main.WIDTH, Main.HEIGHT, 0x995555));
			
			
			this.tip = new Label();
			
			this.tip.x = 150;
			this.tip.y = 150;
			
			this.addChild(this.tip);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(TipScreen.showTip);
			flow.addUpdateListener(TipScreen.hideTip);
			
			root.addChild(this);
			this.visible = false;
		}
		
		update function showTip(code:int):void
		{
			this.tip.text = this.tips[code];
			
			this.visible = true;
		}
		
		update function hideTip():void
		{
			this.visible = false;
		}
	}

}