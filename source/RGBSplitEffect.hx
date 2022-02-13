package;

// STOLEN FROM HAXEFLIXEL DEMO LOL
import flixel.system.FlxAssets.FlxShader;

class RGBSplitEffect
{
	public var shader(default, null):RGBSplitShader = new RGBSplitShader();
	public var strength(default, set):Float = 1;
	public var distance(default, set):Float = 0.02;
	public var direction(default, set):Float = 0;

	public function new():Void
	{
		shader.uStrength.value = [strength];
		shader.uDistance.value = [distance];
		shader.uDirection.value = [direction];
	}

	function set_strength(v:Float):Float
	{
		strength = v;
		shader.uStrength.value = [strength];
		return v;
	}

	function set_distance(v:Float):Float
	{
		distance = v;
		shader.uDistance.value = [distance];
		return v;
	}

	function set_direction(v:Float):Float
	{
		direction = v;
		shader.uDirection.value = [direction];
		return v;
	}
}

class RGBSplitShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		
		uniform float uStrength;
		uniform float uDirection;
		uniform float uDistance;
		
		float blend(float a, float b)
		{
			return ((a - b) * uStrength + b);
		}
		
		void main()
		{
			vec2 dir = vec2(cos(uDirection * 0.01745329252), sin(uDirection * 0.01745329252)) * uDistance;
			vec4 c1 = texture2D(bitmap, openfl_TextureCoordv - dir);
			vec4 c2 = texture2D(bitmap, openfl_TextureCoordv);
			vec4 c3 = texture2D(bitmap, openfl_TextureCoordv + dir);
			
			//gl_FragColor = vec4(c1.r, c2.g, c3.b, (c1.a + c2.a + c3.a) / 3);
			gl_FragColor = vec4(blend(c1.r, c2.r), c2.g, blend(c3.b, c2.b), blend((c1.a + c2.a + c3.a) / 3, c2.a));
		}
		')
	public function new()
	{
		super();
	}
}