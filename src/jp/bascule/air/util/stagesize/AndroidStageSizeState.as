/**
 * Created with IntelliJ IDEA.
 * User: katapad
 * Date: 2013/04/12
 * Time: 21:01
 * To change this template use File | Settings | File Templates.
 */
package jp.bascule.air.util.stagesize
{
public class AndroidStageSizeState extends BaseStageSizeState
{
	public function AndroidStageSizeState()
	{
	}


	/**
	 * Check Invoke only
	 */
	override protected function _invokeHook():void
	{
		_complete();
	}


	/**
	 * ignore resize
	 */
	override protected function _resizeHook():void
	{
	}
}
}
