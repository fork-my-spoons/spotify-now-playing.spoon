local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Spotify Now Playing"
obj.version = "1.2"
obj.author = "Pavel Makhov"
obj.homepage = "https://fork-my-spoons.github.io/"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.spotify_indicator = nil
obj.iconPath = hs.spoons.resourcePath("icons")
obj.playIcon = nil
obj.pauseIcon = nil
local timer = nil

local function refreshWidget()
    if hs.spotify.isRunning() then
        if hs.spotify.isPlaying() then
            obj.spotify_indicator:setIcon(obj.playIcon, false)
        else
            obj.spotify_indicator:setIcon(obj.pauseIcon, false)
        end
        local artist = hs.spotify.getCurrentArtist()
        local track = hs.spotify.getCurrentTrack()
        if artist and track then
            obj.spotify_indicator:setTitle(artist .. ' - ' .. track)
        end
    end
end

function obj:next()
    hs.spotify.next()
    refreshWidget()
end

function obj:prev()
    hs.spotify.previous() 
    refreshWidget()
end

function obj:playpause()
    hs.spotify.playpause() 
    refreshWidget()
end

local function setupTimer()
    timer = hs.timer.new(1, refreshWidget)
end

local function startTimer()
    if not timer:running() then
        timer:start()
    end
end

local function stopTimer()
    if timer:running() then
        timer:stop()
    end
end

function obj:init()
    self.playIcon = hs.image.imageFromPath(obj.iconPath .. '/Spotify_Icon_RGB_Green.png'):setSize({w = 16, h = 16})
    self.pauseIcon = hs.image.imageFromPath(obj.iconPath .. '/Spotify_Icon_RGB_White.png'):setSize({w = 16, h = 16})
    
    app_watcher = hs.application.watcher.new(function(name, event, app)
        if name == 'Spotify' then
            if event == hs.application.watcher.terminated then
                print("Spotify terminated")
                stopTimer()
                if self.spotify_indicator then
                    self.spotify_indicator:removeFromMenuBar()
                end
            elseif event == hs.application.watcher.launched then
                print("Spotify launched")
                setupTimer()
                startTimer()
                self.spotify_indicator = hs.menubar.new():setClickCallback(function()
                    hs.spotify.playpause()
                    refreshWidget()
                end)
            end
        end
    end)
end

function obj:bindHotkeys(mapping)
    local spec = {
        next = hs.fnutils.partial(self.next, self),
        prev = hs.fnutils.partial(self.prev, self),
        playpause = hs.fnutils.partial(self.playpause, self),
    }
    hs.spoons.bindHotkeysToSpec(spec, mapping)
    return self
end

function obj:start()
    if hs.spotify.isRunning() then
        print("Spotify is running")
        self.spotify_indicator = hs.menubar.new():setClickCallback(function()
            hs.spotify.playpause()
            refreshWidget()
        end)
        startTimer()
    end
    app_watcher:start()
end

function obj:stop()
    stopTimer()
    app_watcher:stop()
end

return obj