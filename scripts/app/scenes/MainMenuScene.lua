-- -------------------------------------------------------------------------
--  文件名     ：   MainMenuScene.lua
--  创建者     ：   Sundyhy
--  创建时间    ：  2013/12/6 15:28:03
--  功能描述    ：  plist文件的加载
--
-- -----------------------------------------------------------------------*/
require("scripts/app/base/Util.lua");
require("scripts/app/base/Plistmgr.lua");

local MainMenuScene = class("MainMenuScene", function()
    return display.newScene("MainMenuScene")
end)

function MainMenuScene:ctor()
    self:initBg();
    self:initMenu();
end

function MainMenuScene:initBg()
    local bg = g_PlistMgr:getSprite("btn.plist", "mainmenuback.png");
    bg:setPosition(display.cx, display.cy);

    local bgW = bg:getTextureRect():getMaxX();
    local bgH = bg:getTextureRect():getMaxY();
    bg:setScaleX(display.width / bgW);
    bg:setScaleY(display.height / bgH);
    self:addChild(bg, 0, 1);

    local title = ui.newTTFLabel({
        text = "Defense of the Ancients",
        font = "Arial",
        size = 36,
        color = ccc3(255, 198, 2),
        align = ui.TEXT_ALIGN_CENTER
    });

    title:setPosition(display.width / 2 * 1, display.height / 5 * 4);
    self:addChild(title);

    local version = ui.newTTFLabel({
        text = "Version: 0.0.1.2",
        font = "Arial",
        size = 12,
        color = ccc3(255, 255, 255),
        align = ui.TEXT_ALIGN_CENTER
    });

    version:setPosition(display.width - version:getContentSize().width / 2 - version:getContentSize().height / 2, display.height - version:getContentSize().height / 2);
    self:addChild(version);

end

function MainMenuScene:initMenu()
    local posStartX = display.width / 3 * 2;
    local posStartY = display.height / 3;

    local menuList = {};
    local menuStart = self:createMainMenuBtn("Start Game", posStartX, posStartY  + posStartY / 2, 1);
    local menuLoad  = self:createMainMenuBtn("Load  Game", posStartX, posStartY, 2);
    local menuHelp  = self:createMainMenuBtn("Game  Help", posStartX, posStartY - posStartY / 2, 3);

    local mainMenu = ui.newMenu({menuStart, menuLoad, menuHelp});
    
    mainMenu:setPosition(ccp(0, 0));
    self:addChild(mainMenu);
end

function MainMenuScene:createMainMenuBtn(btnTitle, x, y, itemTag)
    local btnnSprite = g_PlistMgr:getSprite("btn.plist", "big_btn_n.png");
    local btnpSprite = g_PlistMgr:getSprite("btn.plist", "big_btn_p.png");

    local menuItem = ui.newImageMenuItem({
        image = btnnSprite,
        imageSelected = btnpSprite,
        tag = itemTag,
        listener = clickFunc(self, self.onMenuClick)
    });

    local menuItemName = ui.newTTFLabel({
        text = btnTitle,
        font = "Arial",
        size = 28,
        align = ui.TEXT_ALIGN_CENTER -- 文字内部居中对齐
    });

    local itemSize = menuItem:rect().size;
    menuItemName:setPosition(ccp(itemSize.width / 2, itemSize.height / 2));
    menuItem:addChild(menuItemName);

    menuItem:setScaleX(0.8);
    menuItem:setScaleY(0.8);

    menuItem:setPosition(ccp(x, y));

    return menuItem;
end

function MainMenuScene:onMenuClick(tag)
    if tag == 1 then
        self:change2Start();
    end
    if tag == 2 then
        self:change2Load();
    end
    if tag == 3 then
        self:change2Help();
    end
end

function MainMenuScene:change2Start()
    print("Start Game");
end

function MainMenuScene:change2Load()
    print("Load Game");
end

function MainMenuScene:change2Help()
    print("Game Help");
end

function MainMenuScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end

function MainMenuScene:onExit()
end

return MainMenuScene
