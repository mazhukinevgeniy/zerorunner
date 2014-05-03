package game.ui 
{
	import game.fuel.IFuel;
	import game.GameElements;
	import game.interfaces.IRestorable;
	import starling.display.Quad;
	import starling.display.Sprite;
	import utils.updates.update;
	
	internal class FuelView implements IRestorable
	{
		private var fuel:IFuel;
		
		private var indicator:Quad;
		
		public function FuelView(elements:GameElements) 
		{
			this.fuel = elements.fuel;
			
			elements.displayRoot.addChild(this.drawBody());
			
			elements.restorer.addSubscriber(this);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
		}
		
		private function drawBody():Sprite
		{
			const cap:int = this.fuel.getFuelCap();
			
			const width:int = cap + 4;
			const height:int = 20;
			
			var body:Sprite = new Sprite();
			
			var back:Quad = new Quad(width, height, 0xAA6666);
			body.addChild(back);
			
			this.indicator = new Quad(1, height - 4, 0xFF7777);
			this.indicator.x = 2;
			this.indicator.y = 2;
			body.addChild(this.indicator);
			
			body.x = 2;
			body.y = Main.HEIGHT - (2 + height);
			
			return body;
		}
		
		public function restore():void
		{
			this.indicator.scaleX = this.fuel.getAmountOfFuel();
		}
		
		update function numberedFrame(frame:int):void
		{
			if (frame == Game.FRAME_TO_ACT)
			{
				this.indicator.scaleX = this.fuel.getAmountOfFuel();
			}
		}
	}

}