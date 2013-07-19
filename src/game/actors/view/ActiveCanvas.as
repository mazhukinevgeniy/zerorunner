package game.actors.view 
{
	import chaotic.core.update;
	import game.actors.ActorsFeature;
	import game.actors.view.DrawenActor;
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
		private var atlas:TextureAtlas;
		
		private var objects:Vector.<DrawenActor>;
		
		private var container:Sprite;
		
		public function ActiveCanvas(flow:IUpdateDispatcher)
		{
			this.objects = new Vector.<DrawenActor>(ActorsFeature.CAP + 1, true);
			this.container = new Sprite();
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ZeroRunner.quitGame);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.ACTORS, this.container);
		}
		
		update function prerestore():void
		{
			this.container.removeChildren();
			this.atlas = this.assets.getTextureAtlas("gameAtlas"); //TODO: can remove the entire method
		}
		
		update function quitGame():void
		{
			this.container.removeChildren();
		}
		
		public function actorSpawned(id:int, cell:CellXY, type:String):void
		{
			var image:Image = this.objects[id] = new DrawenActor(this.atlas.getTexture("badsprite" + type));
			image.x = cell.x * Metric.CELL_WIDTH;
			image.y = cell.y * Metric.CELL_HEIGHT;
			
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
		
		
		public function actorDeadlyDamaged(id:int):void
		{
			var image:Image = this.objects[id];
			var tween:Tween = new Tween(image, 0.5);
			tween.scaleTo(0);
			tween.moveTo(image.x + image.width / 2, image.y + image.height / 2);
			tween.onComplete = this.unparent;
			tween.onCompleteArgs = [image];
			
			DrawenActor.iJuggler.add(tween);
		}
		
		public function actorFallen(id:int):void
		{
			this.actorDisappeared(id);
		}
		
		public function actorDisappeared(id:int):void
		{
			this.unparent(this.objects[id]);
		}
		
		private function unparent(item:DisplayObject):void
		{
			this.container.removeChild(item);
		}
		
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			DrawenActor.iJuggler = table.getInformer(Juggler);
		}
	}

}