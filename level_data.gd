extends Node

#amount of cats for each level
var catAmount = [1,5,10]

#obstacles to unhide for each level
#format [array0(level 0)[obstaclename1, obstaclename2, etc], array1(level 1)[obstaclename1, obstaclename2, etc], [etc]]
var obstacles = [[],["TallFence"],[]]

#dialogue to play each level
#format [array0(level 0)[[who is talking in scene one, who is talking in scene two, etc]
#, [what side they are on in scene one, what side they are on in scene two, etc]
#, [their dialogue in scene one, their dialogue in scene two, etc]]

#, array1(level 1)[[who is talking in scene one, who is talking in scene two, etc]
#, [what side they are on in scene one, what side they are on in scene two, etc]
#, [their dialogue in scene one, their dialogue in scene two, etc]]]
var dialogue = [
#level 0
[["grilldad.png", "player.pong"
],[true, false
],["hey man can you get rid these cats for me please (i am walter white)", "yeah man i can get rid of your cats, btw im jesse pinkman"
]],
#level 1
[["officedad.poing", "player.fish", "officedad.tscn"
],[true, true, false, true
],["get thesee ccats off my damn lawn or you are not the guy", "btw im mike trout", "im pink man still yes i will remove cats", "thank you (said by michael erhmantrout)"
]],
#level 2
[[
],[
],[
]]]
