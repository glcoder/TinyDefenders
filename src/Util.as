package  
{
	import org.flixel.*;
	
	/**
	 * Utility functions
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Util  {
		public static function getRandomEntity(entities:FlxGroup):FlxSprite {
			if (entities.countLiving() < 1)
				return null;
			
			var entity:FlxSprite = null;
			while (entity == null || !entity.alive)
				entity = entities.getRandom() as FlxSprite;
			
			return entity;
		}
	}
}
