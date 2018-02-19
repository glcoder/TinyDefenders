package  
{
	/**
	 * Game assets
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Assets  {
		[Embed(source = '../assets/clouds.png')]
		public static const CLOUDS:Class;
		
		[Embed(source = '../assets/player.png')]
		public static const PLAYER:Class;
		
		[Embed(source = '../assets/enemies.png')]
		public static const ENEMIES:Class;
		
		[Embed(source = '../assets/defenders.png')]
		public static const DEFENDERS:Class;
		
		[Embed(source = '../assets/laser.png')]
		public static const LASER:Class;
		
		[Embed(source = '../assets/explosion.png')]
		public static const EXPLOSION:Class;
		
		[Embed(source = '../assets/laser.mp3')]
		public static const SFX_LASER:Class;
		
		[Embed(source = '../assets/explosion.mp3')]
		public static const SFX_EXPLOSION:Class;
		
		[Embed(source = '../assets/click.mp3')]
		public static const SFX_CLICK:Class;
	}
}
