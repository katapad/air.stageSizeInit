/**
 * Created with IntelliJ IDEA.
 * User: katapad
 * Date: 2013/04/12
 * Time: 18:29
 * To change this template use File | Settings | File Templates.
 */
package jp.bascule.air.util.stagesize
{
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.InvokeEvent;
import flash.system.Capabilities;

public class BaseStageSizeState implements IStageSizeState
{
	protected var _documentLayer:Sprite;
	protected var _stage:Stage;
	protected var _invoked:Boolean;
	protected var _resizeCount:int;
	protected var _callback:Function;
	private var _ignoreResize:Boolean;
	protected var _added:Boolean;
	private var _onAddedCallback:Function;


	public function BaseStageSizeState(ignoreResize:Boolean = true)
	{
		_ignoreResize = ignoreResize;
		_init();
	}

	private function _init():void
	{

	}

	public function init(documentLayer:Sprite, onAdded:Function, callback:Function):void
	{
		_documentLayer = documentLayer;
		_onAddedCallback = onAdded;
		_callback = callback;

		NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, _onInvoke);

		_checkAdded();
	}

	private function _onInvoke(event:InvokeEvent):void
	{
//		trace('invoke');
//		_logStageSize();

		NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, _onInvoke);
		_invoked = true;
		_invokeHook();
	}

	protected function _invokeHook():void
	{
		if (_isValidStageSize())
			_complete();
	}

	protected function _isValidStageSize():Boolean
	{
		return _stage.stageWidth == _stage.fullScreenWidth;
	}

	private function _checkAdded():void
	{
		if (_documentLayer.stage)
			_onAdded();
		else
			_documentLayer.addEventListener(Event.ADDED_TO_STAGE, _onAdded);
	}

	private function _onAdded():void
	{
		_stage = _documentLayer.stage;
		_documentLayer.removeEventListener(Event.ADDED_TO_STAGE, _onAdded);
		_added = true;
		_doAddedCallback();

		if (_ignoreResize)
		{
			if (_invoked)
				_complete();
		}
		else
		{
			_stage.addEventListener(Event.RESIZE, _onResize);
//			_stage.addEventListener(Event.ENTER_FRAME, _checkEnterframe);
		}
	}

	private function _doAddedCallback():void
	{
		if (_onAddedCallback is Function)
			_onAddedCallback();
	}

	private function _checkEnterframe(event:Event):void
	{
//		_logStageSize()
		if (_isValidStageSize())
		{
			_stage.addEventListener(Event.ENTER_FRAME, _checkEnterframe);
			_complete();
		}

	}

	private function _onResize(event:Event):void
	{
//		trace('resize');
//		_logStageSize();

		_resizeCount++;
		_resizeHook();
	}

	protected function _resizeHook():void
	{

	}

	protected function _complete():void
	{
		_doCallback();
		_destroy();
	}

	private function _doCallback():void
	{
		if (_callback is Function)
			_callback();
	}

	private function _destroy():void
	{
		_callback = null;
		_stage.removeEventListener(Event.RESIZE, _onResize);
		_documentLayer = null;
		_stage = null;
	}







	private function _logStageSize():void
	{

		var list:Array = [Capabilities.screenResolutionX, Capabilities.screenResolutionY, Capabilities.screenDPI,
			_stage.fullScreenWidth, _stage.fullScreenHeight,
			_stage.stageWidth, _stage.stageHeight];
		trace('-------')
		trace(['screenResolutionX', 'screenResolutionY', 'screenDPI',
				'fullScreenWidth', 'fullScreenHeight', 'stageWidth', 'stageHeight'].join('\t'))
		trace(list.join('\t'));
		trace('-------')
	}




}
}
