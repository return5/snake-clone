local LinkedList <const> = require('collection.LinkedList')

local ll <const> = LinkedList:new()
ll:add(1)
ll:add(2)
--ll:add(3)
ll:addAt(2,6)
ll:addAt(2,5)
--ll:add(4)
--ll:add(5)

ll:iterateBackwardsExcludeHead(function(node)io.write("node is: ",node.item,"\n")  end)
