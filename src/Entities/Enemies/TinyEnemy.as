package Entities.Enemies 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import Entities.*;
	
	/**
	 * Tiny enemy
	 * 
	 * @author Artem Gurevich / RadicalEd
	 */
	public class TinyEnemy extends Ship {
		private var m_shootTimer:FlxTimer;
		
		public function TinyEnemy(X:Number, Y:Number) {
			super(X, Y);
			loadGraphic(Assets.ENEMIES, true, false, 16, 16);
			randomFrame();
			
			m_shootTimer = new FlxTimer();
			m_shootTimer.start(FlxMath.randFloat(0.8, 1.2), 0, shoot);
			
			m_range = FlxMath.randFloat(64, 196);
			m_speed = FlxMath.randFloat(45, 135);
			
			health = 1.0;
		}
		
		private function shoot(timer:FlxTimer):void {
			if (!(FlxG.state is GameState))
				return;
			
			var gameState:GameState = FlxG.state as GameState;
			
			if (!alive) {
				timer.stop();
				gameState.enemies.remove(this);
				return;
			}
			
			if (m_target == null || !m_target.alive)
				return;
			
			var targetPosition:FlxPoint = m_target.getMidpoint();
			var position:FlxPoint = getMidpoint();
			var shootRange:Number = m_range * 2;
			
			if (FlxU.getDistance(targetPosition, position) <= shootRange)
				gameState.projectiles.add(new Projectile(position.x, position.y, m_target));
		}
		
		override public function update():void  {
			if (!(FlxG.state is GameState)) {
				super.update();
				return;
			}
			
			var gameState:GameState = FlxG.state as GameState;
			
			if (m_target == null || m_target == gameState.player || m_target.alive == false) {
				var entity:FlxSprite = Util.getRandomEntity(gameState.defenders);
				if (entity != null) {
					m_target = entity;
				} else if (m_target != gameState.player) {
					m_target = gameState.player;
				}
			}
			
			super.update();
		}
	}
}
