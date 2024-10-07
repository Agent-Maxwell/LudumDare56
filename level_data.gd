extends Node

#amount of cats for each level
var catAmount = [1,2,3,3,3,3,3,3,3]

#obstacles to unhide for each level
#format [array0(level 0)[obstaclename1, obstaclename2, etc], array1(level 1)[obstaclename1, obstaclename2, etc], [etc]]
var unhideObstacles = [
["Grill", "Shrubbery","ChainLinkFence"],
["Grill", "Shrubbery", "ChainLinkFence"],
["Grill", "Shrubbery", "PicketFence","PicketFenceCollider", "Trampoline"],
["Grill", "Shrubbery", "PicketFence","PicketFenceCollider", "Trampoline", "TrampolineRedirector"],
["Grill", "Shrubbery", "PicketFence","PicketFenceCollider", "Trampoline", "TrampolineRedirector", "Blower"],
["Grill", "Shrubbery", "PicketFence","PicketFenceCollider", "Trampoline", "TrampolineRedirector", "Blower", "Drone"],
["Grill", "Shrubbery", "MetalFence","MetalFenceCollider", "Trampoline", "TrampolineRedirector", "Blower", "Drone", "PoolUnfilled"],
["Grill", "Shrubbery", "MetalFence","MetalFenceCollider", "Trampoline", "TrampolineRedirector", "Blower", "Drone", "PoolFilled", "HardLight"],
["Grill", "Shrubbery", "MetalFence","MetalFenceCollider", "Trampoline", "TrampolineRedirector", "Blower", "Drone", "PoolUnfilled", "HardLight"]]

#obstacles to have active for each level (all obstacles are deactivated between levels)
#format [array0(level 0)[obstaclename1, obstaclename2, etc], array1(level 1)[obstaclename1, obstaclename2, etc], [etc]]
var activateObstacles = [
["Shrubbery"],
["Grill"],
["Shrubbery", "PicketFenceCollider"],
["Grill", "PicketFenceCollider", "Trampoline"],
["Shrubbery", "PicketFenceCollider", "TrampolineRedirector"],
["Grill", "PicketFenceCollider", "Trampoline", "TrampolineRedirector", "Blower"],
["Shrubbery", "MetalFenceCollider", "TrampolineRedirector", "Drone", "PoolUnfilled"],
["Grill", "MetalFenceCollider", "Trampoline", "TrampolineRedirector", "PoolFilled"],
["Shrubbery", "MetalFenceCollider","TrampolineRedirector", "Drone", "PoolUnfilled", "HardLight"]]
