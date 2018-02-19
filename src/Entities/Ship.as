package Entities 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Entities.Enemies.TinyEnemy;
	
	/**
	 * General ship
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Ship extends FlxSprite {
		protected var m_range:Number;
		protected var m_speed:Number;
		protected var m_target:FlxSprite;
		private var m_randomPoint:FlxPoint;
		
		public function Ship(X:Number, Y:Number) {
			super(X, Y);
			
			m_range  = 64;
			m_speed  = 75;
			m_target = null;
			
			m_randomPoint = null;
		}
		
		override public function update():void  {
			if (m_target == null) {
				super.update();
				return;
			}
			
			if (health <= 0) {
				kill();
				
				if (this is TinyEnemy)
					++FlxG.score;
			}
			
			velocity.make(0, 0);
			
			var targetPosition:FlxPoint = (m_target == null || !m_target.alive ? getMidpoint() : m_target.getMidpoint());
			var position:FlxPoint = getMidpoint();
			var direction:FlxPoint = new FlxPoint(targetPosition.x - position.x, targetPosition.y - position.y);
			
			var length:Number = FlxMath.vectorLength(direction.x, direction.y);
			if (length > 1e-6) {
				direction.x /= length;
				direction.y /= length;
				
				angle = FlxMath.asDegrees(FlxMath.atan2( -direction.y, -direction.x));
				
				if (FlxU.getDistance(targetPosition, position) >= m_range)
					velocity.make(direction.x * m_speed, direction.y * m_speed);
			}
			
			super.update();
		}
	}
}
