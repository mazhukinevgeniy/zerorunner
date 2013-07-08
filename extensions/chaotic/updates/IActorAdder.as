package chaotic.updates 
{
	import chaotic.actors.storage.Puppet;
	
	public interface IActorAdder
	{
		function addActor(puppet:Puppet):void;
	}
	
}