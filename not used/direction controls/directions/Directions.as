package view.features.input.directions 
{
	import starling.display.Sprite;
	import flash.events.MouseEvent;
	import chaotic.core.commands.ICommand;
	import model.features.input.InputPiece;
	import game.metric.DCellXY;
	
	public class Directions extends Sprite
	{
		protected var newInputPiece:ICommand;
		
		private var up:DirectionBase, down:DirectionBase, right:DirectionBase, left:DirectionBase;
		
		public function Directions() 
		{
			this.addChild(this.up = new Up(this));
			this.addChild(this.down = new Down(this));
			this.addChild(this.right = new Right(this));
			this.addChild(this.left = new Left(this));
			
			this.up.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseOverUp);
 			this.down.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseOverDown);
 			this.right.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseOverRight);
 			this.left.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseOverLeft);
			
			this.right.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutRight);
			this.left.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutLeft);
			this.up.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutUp);
			this.down.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutDown);
		}
		
		internal function ringActivated():void
		{
			this.up.showTriangle();
			this.down.showTriangle();
			this.right.showTriangle();
			this.left.showTriangle();
			
			
			this.right.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverRight);
			this.left.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverLeft);
			this.up.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverUp);
			this.down.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverDown);
		}
		
		protected function hideAll():void
		{
			this.up.hideTriangle();
			this.down.hideTriangle();
			this.right.hideTriangle();
			this.left.hideTriangle();
			
			this.right.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverRight);
			this.left.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverLeft);
			this.up.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverUp);
			this.down.removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverDown);
		}
		
		
		protected function mouseOverRight(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, true, new DCellXY(1, 0))); }
		protected function mouseOverLeft(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, true, new DCellXY(-1, 0))); }
		protected function mouseOverUp(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, true, new DCellXY(0, -1))); }
		protected function mouseOverDown(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, true, new DCellXY(0, 1))); }
		
		protected function mouseOutRight(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, false, new DCellXY(1, 0))); }
		protected function mouseOutLeft(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, false, new DCellXY(-1, 0))); }
		protected function mouseOutUp(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, false, new DCellXY(0, -1))); }
		protected function mouseOutDown(event:MouseEvent):void { this.newInputPiece.spread(new InputPiece(false, false, new DCellXY(0, 1))); }
	}

}