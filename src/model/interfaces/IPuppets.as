package model.interfaces 
{
	import model.items.PuppetBase;
	
	public interface IPuppets 
	{
		function findObjectByCell(x:int, y:int):PuppetBase;
	}
	
}