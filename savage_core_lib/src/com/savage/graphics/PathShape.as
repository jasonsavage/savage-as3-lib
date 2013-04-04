package com.savage.graphics 
{
	import com.savage.graphics.core.DrawnShape;
	import com.savage.graphics.core.SolidShape;
	import com.savage.graphics.styles.SolidFillStyle;
	
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class PathShape extends SolidShape
	{
		private var _data:String;
		
		private var _commands:RegExp = /[a-zA-Z]/;
		private var _numbers:RegExp = /[0-9.-]/;
		
		/**
		 * Constructor
		 */
		public function PathShape(data:String="", color:uint = 0) 
		{
			super(10, 10, new SolidFillStyle(color));
			_data = data;
		}
		
		override public function clone():DrawnShape 
		{
			return new PathShape(_data, SolidFillStyle(fillStyle).color);
		}
		
		override protected function draw():void 
		{
			var dataArray:Array = parseData(data);
			
			var lastCommand:String = "m";
			var segments:Array = new Array();
			
			//Build the segments array
			while (dataArray.length)
			{
				var cmd:String 	= dataArray[0];
				
				if (!_commands.test(cmd))
				{
					if (lastCommand == "m")
						lastCommand = "l";
						
					if (lastCommand == "M")
						lastCommand = "L";
						
					cmd = lastCommand;
				}
				else
				{
					dataArray.shift();
				}
				
				switch(cmd)
				{
					case "M" :
					case "m" :

						segments.push( new MoveSegment((cmd == "m"), 
											parseFloat(dataArray.shift()), 
											parseFloat(dataArray.shift())) );
					break;
					
					case "L" :
					case "l" :

						segments.push( new LineSegment((cmd == "l"), 
											parseFloat(dataArray.shift()), 
											parseFloat(dataArray.shift())) );
					break;
					
					case "H" :
					case "h" :

						segments.push( new HorzSegment((cmd == "h"), 
											parseFloat(dataArray.shift())) );
					break;
					
					case "V" :
					case "v" :

						segments.push( new VertSegment((cmd == "v"), 
											parseFloat(dataArray.shift())) );
					break;
					
					case "Q" :
					case "q" :

						segments.push( new QuadSegment((cmd == "q"), 
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift())) );
					break;
					
					case "C" :
					case "c" :

						segments.push( new CubicBezierSegment((cmd == "c"),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift()),
											parseFloat(dataArray.shift())) );
					break;
					
					case "Z" :
					case "z" :
					
						segments.push( new LineSegment((cmd == "z"), 
											parseFloat(dataArray.shift()), 
											parseFloat(dataArray.shift())) );
					break;
				}
				
				lastCommand = cmd;
			}
			
			
			var last:Point = new Point();
			
			if (segments.length > 0)
			{
				for (var i:int = 0; i < segments.length; i++)
				{
					var s:Segment = segments[i];
					last = s.draw(graphics, last);			
				}
			}
			
			super.draw();
		}
		
		/**
		 * Takes a string a returns an array of values
		 * @param	data
		 * @return
		 */
		private function parseData(data:String):Array
		{
			var res:Array = new Array();
			
			var charIndex:int = 0;
			var numString:String = "";
			
			while (charIndex < data.length)
			{
				var c:String = data.charAt(charIndex);
				
				if (_commands.test(c))
				{
					if (numString != "")
					{
						res.push(numString);
						numString = "";
					}
					
					res.push(c);
				}
				else if (_numbers.test(c))
				{
					//collect chars up till the next space
					numString += c;
				}
				else
				{
					//whitespace
					if (numString != "")
					{
						res.push(numString);
						numString = "";
					}
				}

				charIndex++;
			}
			
			//collect any remaining numbers
			if (numString != "")
			{
				res.push(numString);
				numString = "";
			}
			
			return res;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get data():String { return _data; }
		public function set data(value:String):void
		{
			_data = value;
			invalidateProperties();
		}
	}
}

import flash.display.Graphics;
import flash.geom.Point;

/**************************************
 * Helper classes
 **************************************/

class Segment 
{
	protected var _relative:Boolean;
	
	public function Segment(relative:Boolean)
	{
		_relative = relative;
	}
	
	public function draw(canvas:Graphics, last:Point):Point 
	{ 
		return last;
	}
}

class MoveSegment extends Segment 
{
	protected var _x:Number;
	protected var _y:Number;
	
	public function MoveSegment(relative:Boolean, x:Number, y:Number) 
	{
		super(relative);
		_x = x;
		_y = y;
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var next:Point = (_relative) ? new Point(last.x + _x, last.y + _y) : new Point(_x, _y);
		canvas.moveTo(next.x, next.y);
		return next;
	}
}

class LineSegment extends MoveSegment 
{
	public function LineSegment(relative:Boolean, x:Number, y:Number)  
	{
		super(relative, x, y);
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var next:Point = (_relative) ? new Point(last.x + _x, last.y + _y) : new Point(_x, _y);
		canvas.lineTo(next.x, next.y);
		return next;
	}
	
}

class HorzSegment extends Segment 
{
	protected var _x:Number;
	
	public function HorzSegment(relative:Boolean, x:Number)
	{
		super(relative);
		_x = x;
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var next:Point = (_relative) ? new Point(last.x + _x, last.y) : new Point(_x, last.y);
		canvas.lineTo(next.x, next.y);
		return next;
	}
}

class VertSegment extends Segment 
{
	protected var _y:Number;
	
	public function VertSegment(relative:Boolean, y:Number)
	{
		super(relative);
		_y = y;
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var next:Point = (_relative) ? new Point(last.x, last.y + _y) : new Point(last.x, _y);
		canvas.lineTo(next.x, next.y);
		return next;
	}
}

class QuadSegment extends LineSegment 
{
	
	protected var _c1x:Number;
	protected var _c1y:Number;
	
	public function QuadSegment(relative:Boolean, c1x:Number, c1y:Number, x:Number, y:Number)
	{
		super(relative, x, y);
		_c1x = c1x;
		_c1y = c1y;
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var control:Point = (_relative) ? new Point(last.x + _c1x, last.y + _c1y) : new Point(_c1x, _c1y);
		var next:Point = (_relative) ? new Point(last.x + _x, last.y + _y) : new Point(_x, _y);
		
		canvas.curveTo(control.x, control.y, next.x, next.y);	
		return next;
	}
}

class CubicBezierSegment extends QuadSegment 
{
	protected var _c2x:Number;
	protected var _c2y:Number;
	
	public function CubicBezierSegment(relative:Boolean, c1x:Number, c1y:Number, c2x:Number, c2y:Number, x:Number, y:Number)
	{
		super(relative, c1x, c1y, x, y);
		_c2x = c2x;
		_c2y = c2y;
	}
	
	override public function draw(canvas:Graphics, last:Point):Point 
	{
		var control1:Point = (_relative) ? new Point(last.x + _c1x, last.y + _c1y) : new Point(_c1x, _c1y);
		var control2:Point = (_relative) ? new Point(last.x + _c2x, last.y + _c2y) : new Point(_c2x, _c2y);
		var next:Point = (_relative) ? new Point(last.x + _x, last.y + _y) : new Point(_x, _y);
		
		var qPts:QuadraticPoints = getQuadraticPoints(last.x, last.y, control1.x, control1.y, control2.x, control2.y, next.x, next.y);
		
		//from Flex 4
		canvas.curveTo(qPts.control1.x, qPts.control1.y, qPts.anchor1.x, qPts.anchor1.y);
		canvas.curveTo(qPts.control2.x, qPts.control2.y, qPts.anchor2.x, qPts.anchor2.y);
		canvas.curveTo(qPts.control3.x, qPts.control3.y, qPts.anchor3.x, qPts.anchor3.y);
		canvas.curveTo(qPts.control4.x, qPts.control4.y, qPts.anchor4.x, qPts.anchor4.y);
		
		return next;
	}
	
	//from Flex 4
	private function getQuadraticPoints(prevX:Number, prevY:Number, control1X:Number, control1Y:Number, control2X:Number, control2Y:Number, x:Number, y:Number):QuadraticPoints
	{
		var p1:Point = new Point(prevX, prevY);
		var p2:Point = new Point(x, y);
		var c1:Point = new Point(control1X, control1Y);     
		var c2:Point = new Point(control2X, control2Y);
			
		// calculates the useful base points
		var PA:Point = Point.interpolate(c1, p1, 3/4);
		var PB:Point = Point.interpolate(c2, p2, 3/4);
	
		// get 1/16 of the [p2, p1] segment
		var dx:Number = (p2.x - p1.x) / 16;
		var dy:Number = (p2.y - p1.y) / 16;

		var _qPts:QuadraticPoints = new QuadraticPoints();
		
		// calculates control point 1
		_qPts.control1 = Point.interpolate(c1, p1, 3/8);
	
		// calculates control point 2
		_qPts.control2 = Point.interpolate(PB, PA, 3/8);
		_qPts.control2.x -= dx;
		_qPts.control2.y -= dy;
	
		// calculates control point 3
		_qPts.control3 = Point.interpolate(PA, PB, 3/8);
		_qPts.control3.x += dx;
		_qPts.control3.y += dy;
	
		// calculates control point 4
		_qPts.control4 = Point.interpolate(c2, p2, 3/8);
	
		// calculates the 3 anchor points
		_qPts.anchor1 = Point.interpolate(_qPts.control1, _qPts.control2, 0.5); 
		_qPts.anchor2 = Point.interpolate(PA, PB, 0.5); 
		_qPts.anchor3 = Point.interpolate(_qPts.control3, _qPts.control4, 0.5); 
	
		// the 4th anchor point is p2
		_qPts.anchor4 = p2;
		
		return _qPts;      
	}
	
}
class QuadraticPoints
{
    public var control1:Point;
    public var anchor1:Point;
	
    public var control2:Point;
    public var anchor2:Point;
	
    public var control3:Point;
    public var anchor3:Point;
	
    public var control4:Point;
    public var anchor4:Point;
    
    public function QuadraticPoints()
    {
        super();
    }
}