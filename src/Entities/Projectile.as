package Entities 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * General projectile
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class Projectile extends FlxSprite {
		private var m_target:FlxSprite;
		
		public function Projectile(X:Number, Y:Number, target:FlxSprite) {
			super(X, Y);
			this.m_target = target;
			
			loadGraphic(Assets.LASER, true, false, 16, 6, true);
			
			x -= width * 0.5;
			y -= height * 0.5;
			
			FlxG.play(Assets.SFX_LASER, 0.3);
		}
		
		override public function update():void  {
			if (!(FlxG.state is GameState)) {
				super.update();
				return;
			}
			
			var gameState:GameState = FlxG.state as GameState;
			
			if (!onScreen()) {
				kill();
				gameState.projectiles.remove(this, true);
			}
			
			if (!m_target.alive) {
				super.update();
				return;
			}
			
			var targetPosition:FlxPoint = m_target.getMidpoint();
			var position:FlxPoint = getMidpoint();
			
			velocity.make(targetPosition.x - position.x, targetPosition.y - position.y);
			var length:Number = FlxMath.vectorLength(velocity.x, velocity.y);
			if (FlxU.abs(length) > 0.1) {
				var factor:Number = 300 / length;
				velocity.x *= factor;
				velocity.y *= factor;
				
				angle = FlxMath.asDegrees(FlxMath.atan2( -velocity.y, -velocity.x));
			} else {
				kill();
				gameState.projectiles.remove(this);
			}
			
			if (FlxCollision.pixelPerfectCheck(this, m_target)) {
				m_target.health -= 0.5;
				kill();
				gameState.projectiles.remove(this);
				gameState.effects.add(new Explosion(x, y));
			}
			
			super.update();
		}
	}
}
