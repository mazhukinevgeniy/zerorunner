package chaotic.actors.manipulator 
{
	import chaotic.actors.storage.Puppet;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.updates.Update;
	
	public interface IActionPerformer 
	{
		function replaceActor(item:Puppet, change:DCellXY):void;
		
		function movedActor(item:Puppet, change:DCellXY, source:String):void;
		function jumpedActor(item:Puppet, change:DCellXY):void;
		
		function blockedActor(item:Puppet, movingAttempt:DCellXY):void;
		
		function damageActor(item:Puppet, damage:int):void;
		
		function destroyActor(item:Puppet):void;
		function detonateActor(item:Puppet):void;
	}
	
}