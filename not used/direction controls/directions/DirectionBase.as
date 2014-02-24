package view.features.input.directions 
{
	import starling.display.Sprite;
	import flash.events.MouseEvent;
	
	internal class DirectionBase extends Sprite
	{
		protected var fullTriangle:Sprite;
		protected var ringPiece:Sprite;
		
		protected var controls:Directions;
		
		public function DirectionBase() 
		{
			this.fullTriangle = new Sprite();
			this.ringPiece = new Sprite();
			
			this.fullTriangle.visible = false;
			
			this.addChild(this.fullTriangle);
			this.addChild(this.ringPiece);
			
			
			
			this.ringPiece.x = Constants.WIDTH / 2 - 45;
			this.ringPiece.y = Constants.HEIGHT / 2 - 45;
			
			
			this.useHandCursor = true;
			
			this.ringPiece.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownOnRing);
		}
		
		private function mouseDownOnRing(event:MouseEvent):void
		{
			this.controls.ringActivated();
		}
		
		internal function hideTriangle():void
		{
			this.fullTriangle.visible = false;
		}
		
		internal function showTriangle():void
		{
			this.fullTriangle.visible = true;
		}
	}

}