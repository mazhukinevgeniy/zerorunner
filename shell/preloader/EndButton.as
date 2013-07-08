package preloader 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class EndButton extends Sprite
	{
		private var title:TextField;
		
		
		public function EndButton()
		{
			var color:uint = 0x098765;
			var width:int = 200;
			var height:int = 20;
			var title:String = "Finish immediately";
			
			this.x = int(Constants.WIDTH / 2 - width / 2);
			this.y = int(Constants.HEIGHT * 2 / 3);
			
			/* код ButtonBase.as */
			this.graphics.beginFill(color);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
			
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			this.title = new TextField();
			this.title.text = title;
			this.title.width = this.width;
			this.addChild(this.title);
			this.title.autoSize = TextFieldAutoSize.CENTER;
		}
		
	}

}