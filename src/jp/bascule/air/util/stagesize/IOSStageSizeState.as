/**
 * Created with IntelliJ IDEA.
 * User: katapad
 * Date: 2013/04/12
 * Time: 12:15
 * To change this template use File | Settings | File Templates.
 */
package jp.bascule.air.util.stagesize
{
import flash.system.Capabilities;

public class IOSStageSizeState extends BaseStageSizeState
{
	public function IOSStageSizeState()
	{
		super(false);
	}


	/**
	 * ignore invoke hook
	 */
	override protected function _invokeHook():void
	{
	}

	/**
	 * can get correct stage size after invoke
	 */
	override protected function _resizeHook():void
	{
		if (!_invoked)
			return;

		if (_isValidStageSize())
			_complete();
	}


}
}
