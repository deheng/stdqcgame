-- -------------------------------------------------------------------------
--  文件名     ：   LoadGameScene.lua
--  创建者     ：   Sundyhy
--  创建时间    ：  2013/12/6 15:35:55
--  功能描述    ：  加载游戏界面
--
-- -----------------------------------------------------------------------*/

require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene("MainMenuScene")
end

return MyApp
