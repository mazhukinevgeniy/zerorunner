package game.actors.view 
{
	import game.actors.ActorsFeature;
	import game.actors.storage.Puppet;
	import game.actors.view.DrawenActor;
	import game.time.Time;
	import game.ZeroRunner;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.DPixelXY;
	import game.metric.Metric;
	import game.metric.PixelXY;
	import game.ui.Camera;
	import game.ZeroRunner;
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
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ActorsFeature.actorAdded);
			flow.addUpdateListener(ActorsFeature.actorDestroyed);
			flow.addUpdateListener(ActorsFeature.actorMoved);
			flow.addUpdateListener(ActorsFeature.actorJumped);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.ACTORS, this.container);
		}
		
		public function prerestore():void
		{
			this.container.removeChildren();
			this.atlas = this.assets.getTextureAtlas("gameAtlas");
		}
		
		public function actorAdded(puppet:Puppet):void
		{
			var cell:PixelXY = Metric.toPixel(puppet.getCell());
			
			var image:Image = this.objects[puppet.id] = new DrawenActor(this.atlas.getTexture("badsprite" + String(puppet.type)));
			image.x = cell.x;
			image.y = cell.y;
			
			this.container.addChild(image);
		}
		
		public function actorDestroyed(puppet:Puppet):void
		{
			var id:int = puppet.id;
			
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
		
		public function actorMoved(item:Puppet, cChange:DCellXY):void
		{
			var change:DPixelXY = Metric.toPixel(cChange);
			
			var image:Image = this.objects[item.id];
			
			var tween:Tween = new Tween(image, item.remainingDelay * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(image.x + change.x, image.y + change.y);
			
			this.juggler.add(tween);
		}
		
		public function actorJumped(item:Puppet):void
		{
			//if (change.y != 0)
			//	throw new Error("Not implemented");
			//else
			//{
				var id:int = item.id;
				var image:Image = this.objects[id];
				var ticksToGo:int = item.remainingDelay;
				
				var tween:Tween = new Tween(image, ticksToGo * Time.TIME_BETWEEN_TICKS / 2, "easeIn");
				tween.animate("y", image.y - Metric.CELL_HEIGHT / 2);
			//	tween.animate("x", image.x + Metric.toPixel(change).x / 2);
				
				var secondTween:Tween = new Tween(image, ticksToGo * Time.TIME_BETWEEN_TICKS / 2, "easeOut");
				secondTween.animate("y", image.y);
			//	secondTween.animate("x", image.x + Metric.toPixel(change).x);
				
				tween.nextTween = secondTween;
				
				this.juggler.add(tween);
			//} //TODO: redisign
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.juggler = table.getInformer(Juggler);
		}
	}

}