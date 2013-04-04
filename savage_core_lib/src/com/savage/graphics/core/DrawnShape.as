package com.savage.graphics.core 
{
	import com.savage.interfaces.IUDisplayListObject;
	import com.savage.interfaces.IMeasurable;
	import com.savage.interfaces.IUPropertiesObject;
	import com.savage.managers.LayoutManager;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jason Savage
	 */
	public class DrawnShape extends Shape implements IMeasurable, IUPropertiesObject
	{
		private var _drawnWidth:Number;
		private var _drawnHeight:Number;
		private var _drawAnchorPoint:Boolean;
		private var _nestedLevel:int = 0;
		
		private var _invalidateDisplayListFlag:Boolean;
		private var _invalidatePropertiesFlag:Boolean;
		
		/**
		 * Constructor
		 */
		public function DrawnShape(width:Number=10, height:Number=10) 
		{
			super();
			
			_drawnWidth = width;
			_drawnHeight = height;
			
			invalidateProperties();
		}
		
		public function clone():DrawnShape 
		{ 
			return new DrawnShape(drawnWidth, drawnHeight);
		}
		
		public function measureWidth():Number
		{
			return _drawnWidth;
		}
		
		public function measureHeight():Number
		{
			return _drawnHeight;
		}
		
		protected function beginDraw():void {}
		
		protected function draw():void 
		{ 
			if (drawAnchorPoint)
			{
				graphics.endFill();
				graphics.lineStyle(1, 0x99ff00);
				graphics.moveTo(-drawnWidth, 0);
				graphics.lineTo(drawnWidth, 0);
				graphics.moveTo(0, -drawnHeight);
				graphics.lineTo(0, drawnHeight);
				graphics.lineStyle(0);
			}
		}
		
		protected function endDraw():void { }
		
		
		/**
		 * Causes this component to call <code>updateDisplayList()</code> during the next update phase.
		 */
		public function invalidateProperties():void
		{
			if (!_invalidatePropertiesFlag)
			{
				_invalidatePropertiesFlag = true;
				LayoutManager.invalidateProperties(this, nestedLevel);
			}
		}
		
		/**
		 * Loops through the display list and updates the postion of all this component's children.
		 */
		public function updateProperties():void 
		{ 
			//start draw
			beginDraw();
			
			//draw
			draw();
			
			//end draw
			endDraw();
			
			_invalidatePropertiesFlag = false;
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		 
		public function get drawnWidth():Number { return _drawnWidth; }
		public function set drawnWidth(value:Number):void
		{
			_drawnWidth = value;
			invalidateProperties();
		}
		
		public function get drawnHeight():Number { return _drawnHeight; }
		public function set drawnHeight(value:Number):void
		{
			_drawnHeight = value;
			invalidateProperties();
		}
		
		public function get drawAnchorPoint():Boolean { return _drawAnchorPoint; }
		public function set drawAnchorPoint(value:Boolean):void
		{
			_drawAnchorPoint = value;
			invalidateProperties();
		}
		
		/**
		 * @private
		 */
		public function get nestedLevel():int { return _nestedLevel; }
		public function set nestedLevel(value:int):void
		{
			_nestedLevel = value;
		}
		
	}

}