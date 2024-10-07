extends Node

#amount of cats for each level
var catAmount = [1,5,10]

#obstacles to unhide for each level
#format [array0(level 0)[obstaclename1, obstaclename2, etc], array1(level 1)[obstaclename1, obstaclename2, etc], [etc]]
var unhideObstacles = [["Grill", "Shrubbery","ChainLinkFence"],["Grill", "Shrubbery", "ChainLinkFence"],["Grill", "Shrubbery", "PicketFence", "Trampoline"]]

#obstacles to have active for each level (all obstacles are deactivated between levels)
#format [array0(level 0)[obstaclename1, obstaclename2, etc], array1(level 1)[obstaclename1, obstaclename2, etc], [etc]]
var activateObstacles = [["Shrubbery"],["Grill"],["Shrubbery", "PicketFenceCollider"]]
