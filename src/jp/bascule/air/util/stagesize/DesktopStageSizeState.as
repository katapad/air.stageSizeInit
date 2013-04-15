/**
 * Created with IntelliJ IDEA.
 * User: katapad
 * Date: 2013/04/12
 * Time: 18:55
 * To change this template use File | Settings | File Templates.
 */
package jp.bascule.air.util.stagesize
{
public class DesktopStageSizeState extends BaseStageSizeState
{
	public function DesktopStageSizeState()
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
