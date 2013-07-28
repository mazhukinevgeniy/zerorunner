package game.actors.view 
{
	import chaotic.core.update;
	import game.actors.ActorsFeature;
	import game.actors.core.ActorPuppet;
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
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.PixelPerfectTween;
	
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
			flow.addUpdateListener(ActorsFeature.addActor);
			flow.addUpdateListener(ActorsFeature.moveActor);
			flow.addUpdateListener(ActorsFeature.removeActor);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.ACTORS, this.container);
			
			this.pull = new DActorPull();
		}
		
		update function prerestore():void
		{
			var length:int = this.objects.length;
			
			for (var i:int = 0; i < length; i++)
			{
				if (this.objects[i])
					this.removeActor(i);
			}
		}
		
		update function addActor(item:ActorPuppet):void
		{
			var image:DrawenActor = this.objects[item.getID()] = this.pull.getDrawenActor(item.getClassCode());
			
			image.standOn(item.giveCell());
			
			this.container.addChild(image);
		}
		
		update function moveActor(item:ActorPuppet, change:DCellXY, delay:int):void
		{
			var tween:PixelPerfectTween = new PixelPerfectTween(this.objects[id], delay * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(goal.x * Metric.CELL_WIDTH, goal.y * Metric.CELL_HEIGHT);
			
			DrawenActor.iJuggler.add(tween);
			
			this.objects[id].moveNormally(goal, change, delay);
		}
		
		update function removeActor(id:int):void
		{
			var item:DrawenActor = this.objects[id];
			
			this.pull.stash(item);
			if (item.parent == this.container) this.container.removeChild(item);
		}
		
		public function setLayerOf(id:int, layer:int):void
		{
			this.container.setChildIndex(this.objects[id], layer);
		}
		
		
		public function actorJumped(id:int, change:DCellXY, delay:int):void
		{
			this.objects[id].jump(change, delay);
		}
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			DrawenActor.iJuggler = table.getInformer(Juggler);
			DrawenActor.iAtlas = table.getInformer(AssetManager).getTextureAtlas("gameAtlas");
		}
	}

}