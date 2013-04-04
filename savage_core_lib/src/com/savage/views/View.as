package com.savage.views
{
	import com.savage.core.AppComponent;
	import com.savage.graphics.styles.FillStyle;
	import com.savage.graphics.styles.GradientFillStyle;
	import com.savage.graphics.styles.LineStyle;
	import com.savage.interfaces.IView;
	import com.savage.layouts.AbsoluteLayout;
	import com.savage.layouts.LayoutBase;
	import com.savage.utils.MathUtil;
	import com.savage.utils.NumberUtil;
	
	import flash.geom.Rectangle;
	
	/**
	 * The ViewBase class provides all the base methods an properties for all the View classes. 
	 * @author Jason Savage
	 */
	public class View extends AppComponent implements IView
	{
		private var _layout:LayoutBase = new AbsoluteLayout();
		
		private var _background:FillStyle;
		private var _border:LineStyle;
		private var _cornerRadius:int = 0;
		
		private var _top:Object;
		private var _right:Object;
		private var _bottom:Object;
		private var _left:Object;
		private var _horizontalCenter:Object;
		private var _verticalCenter:Object;
		
		private var _clipContent:Boolean;
		private var _internalScrollSet:Boolean;
		
		private var _styleDefinition:Object;
		
		/**
		 * Constructor
		 */
		public function View() 
		{
			super();
			tabEnabled = false;
		}
		
		/**
		 * Gets the style value under the specified key for this view.
		 */
		public function getStyleValue(key:String):Object
		{
			return _styleDefinition[key];
		}
		
		/**
		 * Sets the style value under the specified key for this view.
		 */
		public function setStyleValue(key:String, value:Object):void
		{
			if(!_styleDefinition)
				_styleDefinition = new Object();
			
			_styleDefinition[key] = value;
		}
		
		/**
		 * Sets the style definition for this view.
		 */
		public function setStyleDefinition(value:Object):void
		{
			_styleDefinition = value;
		}
		
		/**
		 * Gets the measured width of this view
		 * @return
		 */
		public function measureWidth():Number
		{
			if ( _layout.width )
			{
				if (_layout.width is String)
				{
					var perc:Number = NumberUtil.percentToDecimal( _layout.width as String ); 
					perc = MathUtil.limit(perc, 0, 1);
					
					return (parentWidth * perc);
				}
				
				if (_layout.width is Number)
				{
					return Number(_layout.width);
				}
			}
			
			return width + _layout.paddingLeft + _layout.paddingRight;
		}
		
		/**
		 * Gets the measured height of this view
		 * @return
		 */
		public function measureHeight():Number
		{
			if ( layout.height )
			{
				if (layout.height is String)
				{
					var perc:Number = NumberUtil.percentToDecimal( layout.height as String );
					perc = MathUtil.limit(perc, 0, 1);
						
					return parentHeight * perc;
				}
				
				if (layout.height is Number)
				{
					return Number(layout.height)
				}
			}
			
			return height + _layout.paddingTop + _layout.paddingBottom;
		}
		
		/**
		 * Gets the width of this View's parent.
		 */
		protected function get parentWidth():Number
		{
			if (parent)
			{
				if (parent is IView)
					return IView(parent).measureWidth();
				else if (stage && parent == stage)
					return stage.stageWidth;
				else
					return parent.width;
			}
			return 0;
		}
		
		/**
		 * Gets the height of this View's parent.
		 */
		protected function get parentHeight():Number
		{
			if (parent)
			{
				if (parent is IView)
					return IView(parent).measureHeight();
				else if (stage && parent == stage)
					return stage.stageHeight;
				else
				
					return parent.height;
			}
			return 0;
		}
		
		/**************************************
		 * Overrides / Protected
		 **************************************/
		
		override public function updateDisplayList():void 
		{
			super.updateDisplayList();

			//update layout
			_layout.updateLayout(this);
			
			//draw border/background
			graphics.clear();
			drawBorderIfNeeded();
			drawBackgroundIfNeeded();
			
			//enable scolling
			clipContentIfNeeded();
		}
		
		/**************************************
		 * Private
		 **************************************/
		
		private function clipContentIfNeeded():void
		{
			if (_clipContent)
			{
				if(!scrollRect || _internalScrollSet)
				{
					_internalScrollSet = true;
					scrollRect = new Rectangle(0, 0, measureWidth(), measureHeight());
				}
			}
			else
			{
				if (scrollRect && _internalScrollSet)
				{
					_internalScrollSet = false;
					scrollRect = null;
				}
			}
		}
		 
		private function drawBorderIfNeeded():void
		{
			if (_border)
			{
				_border.applyLine(graphics);
				graphics.drawRoundRect(0, 0, measureWidth(), measureHeight(), _cornerRadius, _cornerRadius);
			}
		}
		
		private function drawBackgroundIfNeeded():void
		{
			if (_background)
			{
				if(background is GradientFillStyle)
					GradientFillStyle(background).createGradientBox(measureWidth(), measureHeight(), 90);
				
				_background.applyFill(graphics);				

				graphics.drawRoundRect(0, 0, measureWidth(), measureHeight(), _cornerRadius, _cornerRadius);
				graphics.endFill();
			}
		}
		
		/**************************************
		 * Accessors
		 **************************************/
		
		public function get top():Object { return _top; }
		public function set top(value:Object):void
		{
			_top = value;
			_bottom = null;
			_verticalCenter = null;
			
			invalidateDisplayList();
		}
		
		public function get right():Object { return _right; }
		public function set right(value:Object):void
		{
			_right = value;
			_left = null;
			_horizontalCenter = null;
			
			invalidateDisplayList();
		}
		
		public function get bottom():Object { return _bottom; }
		public function set bottom(value:Object):void
		{
			_bottom = value;
			_top = null;
			_verticalCenter = null;
			
			invalidateDisplayList();
		}
		
		public function get left():Object { return _left; }
		public function set left(value:Object):void
		{
			_left = value;
			_right = null;
			_horizontalCenter = null;
			
			invalidateDisplayList();
		}
		
		public function get horizontalCenter():Object { return _horizontalCenter; }
		public function set horizontalCenter(value:Object):void
		{
			_horizontalCenter = value;
			_left = null;
			_right = null;
			
			invalidateDisplayList();
		}
		
		public function get verticalCenter():Object { return _verticalCenter; }
		public function set verticalCenter(value:Object):void
		{
			_verticalCenter = value;
			_top = null;
			_bottom = null;
			
			invalidateDisplayList();
		}
		
		public function get background():FillStyle { return _background; }
		public function set background(value:FillStyle):void
		{
			_background = value;
			invalidateDisplayList();
		}
		
		public function get border():LineStyle { return _border; }
		public function set border(value:LineStyle):void
		{
			_border = value;
			invalidateDisplayList();
		}
		
		public function get cornerRadius():int { return _cornerRadius; }
		public function set cornerRadius(value:int):void
		{
			_cornerRadius = value;
			invalidateDisplayList();
		}
		
		public function get layout():LayoutBase { return _layout; }
		public function set layout(value:LayoutBase):void
		{
			_layout = value;
			invalidateDisplayList();
		}
		
		public function get clipContent():Boolean { return _clipContent; }
		public function set clipContent(value:Boolean):void
		{
			_clipContent = value;
			invalidateDisplayList();
		}
	}

}