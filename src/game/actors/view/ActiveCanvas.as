package game.actors.view 
{
	import chaotic.core.update;
	import game.actors.ActorsFeature;
	import game.actors.view.DrawenActor;
	import game.actors.view.pull.DActorPull;
	import game.time.Time;
	import game.ZeroRunner;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ui.Camera;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class ActiveCanvas implements IActorListener
	{
		private var pull:DActorPull;
		private var objects:Vector.<DrawenActor>;
		
		private var container:Sprite;
		
		public function ActiveCanvas(flow:IUpdateDispatcher)
		{
			this.objects = new Vector.<DrawenActor>(ActorsFeature.CAP + 1, true);
			this.container = new Sprite();
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ZeroRunner.prerestore);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.ACTORS, this.container);
			
			this.pull = new DActorPull();
		}
		
		update function prerestore():void
		{
			var length:int = this.objects.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (this.objects[i])
					this.unparent(i);
			}
		}
		
		public function actorSpawned(id:int, cell:CellXY, type:int):void
		{
			var image:DrawenActor = this.objects[id] = this.pull.getDrawenActor(type);
			
			image.standOn(cell);
			
			this.container.addChild(image);
		}
		
		
		public function actorMovedNormally(id:int, change:DCellXY, delay:int):void
		{
			this.objects[id].moveNormally(change, delay)
		}
		
		public function actorJumped(id:int, change:DCellXY, delay:int):void
		{
			this.objects[id].jump(change, delay);
		}
		
		/*
		public function actorDeadlyDamaged(id:int):void
		{
			var image:Sprite = this.objects[id];
			var tween:Tween = new Tween(image, 0.5);
			tween.scaleTo(0);
			tween.moveTo(image.x + image.width / 2, image.y + image.height / 2);
			tween.onComplete = this.unparent; //TODO: can went wrong
			tween.onCompleteArgs = [image];
			
			DrawenActor.iJuggler.add(tween);
		}*/
		
		public function unparent(id:int):void
		{
			var item:DrawenActor = this.objects[id];
			
			this.pull.stash(item);
			this.container.removeChild(item);
		}
		
		public function setLayerOf(id:int, layer:int):void
		{
			this.container.setChildIndex(this.objects[id], layer);
		}
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			DrawenActor.iJuggler = table.getInformer(Juggler);
			DrawenActor.iAtlas = table.getInformer(AssetManager).getTextureAtlas("gameAtlas");
		}
	}

}