package game.actors.manipulator 
{
	import game.actors.storage.Puppet;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	public interface IActionPerformer 
	{
		function movedActor(item:Puppet, change:DCellXY):void;
		function jumpedActor(item:Puppet, change:DCellXY):void;
		
		function destroyActor(item:Puppet):void;
		function detonateActor(item:Puppet):void;
	}
	
}