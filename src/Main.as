package 
{
	import org.flixel.*;
	[SWF(width = "800", height = "600", backgroundColor = "#FFFFFF")]
	
	/**
	 * Main game class
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Main extends FlxGame 
	{
		public function Main():void 
		{
			super(800, 600, GameState, 1);
			FlxG.mouse.show();
		}
	}
}
