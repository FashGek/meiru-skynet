
local skynet = require "skynet"
local meiru  = require "meiru.meiru"

local config = {
    name = 'meiru', 
    description = 'meiru web framework', 
    keywords = 'meiru skynet lua skynetlua'
}
local test_path = skynet.getenv("test_path")
local views_path  = string.format("%s/assets/view", test_path)
local static_path = string.format("%s/assets/public", test_path)
local static_url = "/"

---------------------------------------
--router
---------------------------------------
local router = meiru.router()

router.get('/index', function(req, res)
    local data = {
        topic = {
            title = "hello ejs.lua"
        },
        topics = {
            {
                title = "topic1"
            },{
                title = "topic2"
            }
        }
    }
    function data.helloworld(...)
        if select("#", ...) > 0 then
            return "come from helloworld function"..table.concat(... , ", ")
        else
            return "come from helloworld function"
        end
    end
	res.render('index', data)
end)

---------------------------------------
--app
---------------------------------------
local app = meiru.create_app()

app.set("views_path", views_path)
app.set("static_url", static_url)
app.data("config", config)
app.set("session_secret", "meiru")
-- app.set("host", "192.168.188.138")
app.use(meiru.static('/public', static_path))

app.use(router.node())
app.run()

local tree = app.treeprint()
log("treeprint\n", tree)

return app

