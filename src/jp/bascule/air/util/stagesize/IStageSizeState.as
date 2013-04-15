/**
 * Created with IntelliJ IDEA.
 * User: katapad
 * Date: 2013/04/12
 * Time: 12:10
 * To change this template use File | Settings | File Templates.
 */
package jp.bascule.air.util.stagesize
{
import flash.display.Sprite;

public interface IStageSizeState
{
	function init(documentLayer:Sprite, onAdded:Function, callback:Function):void;
}
}
