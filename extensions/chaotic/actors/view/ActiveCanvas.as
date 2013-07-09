package chaotic.actors.view 
{
	import chaotic.actors.ActorsFeature;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.view.DrawenActor;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.DPixelXY;
	import chaotic.metric.Metric;
	import chaotic.metric.PixelXY;
	import chaotic.ui.Camera;
	import chaotic.updates.IUpdateDispatcher;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class ActiveCanvas 
	{
		private var assets:AssetManager;
		private var atlas:TextureAtlas;
		
		private var juggler:Juggler;
		
		private var objects:Vector.<Image>;
		
		private var container:Sprite;
		
		public function ActiveCanvas(flow:IUpdateDispatcher)
		{
			this.objects = new Vector.<Image>(ActorsFeature.CAP + 1, true);
			this.container = new Sprite();
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener("prerestore");
			flow.addUpdateListener("addActor");
			flow.addUpdateListener("actorRemoved");
			flow.addUpdateListener("moveActor");
			flow.addUpdateListener("detonateActor");
			flow.addUpdateListener("jumpActor");
			flow.addUpdateListener("getInformerFrom");
			
			flow.dispatchUpdate("addToTheLayer", Camera.SCENE, this.container);
		}
		
		public function prerestore():void
		{
			this.container.removeChildren();
			this.atlas = this.assets.getTextureAtlas("gameAtlas");
		}
		
		public function addActor(puppet:Puppet):void
		{
			var cell:PixelXY = Metric.toPixel(puppet.getCell());
			
			var image:Image = this.objects[puppet.id] = new DrawenActor(this.atlas.getTexture("badsprite" + String(puppet.type)));
			image.x = cell.x;
			image.y = cell.y;
			
			this.container.addChild(image);
		}
		
		public function actorRemoved(id:int):void
		{
			var image:Image = this.objects[id];
			var tween:Tween = new Tween(image, 0.5);
			tween.scaleTo(0);
			tween.moveTo(image.x + image.width / 2, image.y + image.height / 2);
			tween.onComplete = this.unparent;
			tween.onCompleteArgs = [image];
			
			this.juggler.add(tween);
		}
		
		private function unparent(item:DisplayObject):void
		{
			this.container.removeChild(item);
		}
		
		public function moveActor(id:int, cChange:DCellXY, ticksToGo:int):void
		{
			var change:DPixelXY = Metric.toPixel(cChange);
			
			var image:Image = this.objects[id];
			
			var tween:Tween = new Tween(image, ticksToGo * Constants.TIME_BETWEEN_TICKS);
			tween.moveTo(image.x + change.x, image.y + change.y);
			
			this.juggler.add(tween);
		}
		
		public function detonateActor(id:int):void
		{
			var image:Image = this.objects[id];
			
			var tween:Tween = new Tween(image, 0);
			tween.scaleTo(2);
			tween.moveTo(image.x - image.width / 2, image.y - image.height / 2);
			
			this.juggler.add(tween);
		}
		
		public function jumpActor(id:int, change:DCellXY, ticksToGo:int):void
		{
			if (change.y != 0)
				throw new Error("Not implemented");
			else
			{
				var image:Image = this.objects[id];
				
				var tween:Tween = new Tween(image, ticksToGo * Constants.TIME_BETWEEN_TICKS / 2, "easeIn");
				tween.animate("y", image.y - Metric.CELL_HEIGHT / 2);
				tween.animate("x", image.x + Metric.toPixel(change).x / 2);
				
				var secondTween:Tween = new Tween(image, ticksToGo * Constants.TIME_BETWEEN_TICKS / 2, "easeOut");
				secondTween.animate("y", image.y);
				secondTween.animate("x", image.x + Metric.toPixel(change).x);
				
				tween.nextTween = secondTween;
				
				this.juggler.add(tween);
			}
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.juggler = table.getInformer(Juggler);
		}
	}

}