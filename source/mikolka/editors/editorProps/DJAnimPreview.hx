package mikolka.editors.editorProps;

import flxanimate.animate.FlxKeyFrame;

class DJAnimPreview extends AnimPreview {
    public var dj:PlayableCharacter;
    public var offsets:Array<Array<Float>>;
    override function registerAnims(value:FlxAtlasSprite) {
        offsets = new Array<Array<Float>>();
        value.offset.set(0,0);
        @:privateAccess
        for (x in dj.getFreeplayDJData().animations)
			{
                offsets.push(x.offsets);
				addAnim({
					anim: x.prefix,
					readableName: x.name
				});
			}
    }
    override function onFrameAdvance(anim:String, frame:Int)
        {
            if(selectedAnimLength == 0) {
                selectedAnimLength = activeSprite.anim.length; // timeline.totalFrames;
            }
            selectedFrame +=1;
            var curOffset = offsets[selectedIndex];
            frameTxt.text = 'Frame (${selectedFrame}/${activeSprite.anim.length}) [${curOffset[0]},${curOffset[1]}]';
        }
     override function selectFrame(diff:Int = 0)
        {
            activeSprite.pauseAnimation();
            var newFrame = Std.int(FlxMath.bound(selectedFrame+diff,1,selectedAnimLength));
            //activeSprite.anim.curFrame = selectedAnimIndices[newFrame-1];
            activeSprite.anim.curFrame = newFrame-1;
            selectedFrame = newFrame;
            frameTxt.text = 'Frame (${selectedFrame}/${selectedAnimLength})';
        }
    override function playAnim() {
        super.playAnim();
        var curOffset = offsets[selectedIndex];
        activeSprite.offset.set(curOffset[0],curOffset[1]);
        selectedFrame = 1;
    }
    // private function findWhateverShitIsHoldingAnimrnRn(){
    //     var keyFrames = new Array<FlxKeyFrame>();
    //     var indicies = new Array<Dynamic>();
    //     for (label in activeSprite.anim.curSymbol.timeline.getList()){
    //         @:privateAccess
    //         for (frame in label._keyframes){
    //             keyFrames.push(frame);
    //             indicies.push(frame.getFrameIndices());
    //         }
    //     }
    //     trace("lol");
    // }
}