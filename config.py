# This config should be located in ~/.config/qutebrowser/

# DEPENDENCIES
# mpv
# link2qr
# yt-dlp
# gnome-terminal (depends on your DE, changes might be necessary)

# ENABLE
config.load_autoconfig()

# DEFAULTS
c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"

# SEARCH ENGINES
c.url.searchengines = {
        "DEFAULT" : "https://duckduckgo.com/?q={}",
        "5e" : "https://roll20.net/compendium/dnd5e/{}#content", # Dungeons & Dragons (Don't worry Grandma I'm not summoning demons)
        "az" : "https://www.amazon.com/s?k={}", # This is unironically closer to summoning demons
        "b" : "https://www.bing.com/search?q={}",
        "ddg" : "https://duckduckgo.com/?q={}",
        "domain" : "https://whois.domaintools.com/{}", # for looking up domain information
        "g" : "https://google.com/search?q={}",
        "gh" : "https://github.com/search?q={}",
        "herb" : "https://www.iherb.com/search?kw={}", # good organic teas
        "iv" : "https://yewtu.be/results?search_query={}",
        "maps" : "https://www.google.com/maps/search/{}",
        "mg" : "https://metager.org/meta/meta.ger3?eingabe={}",
        "mj" : "https://www.mojeek.com/search?q={}",
        "o" : "https://odysee.com/$/search?q={}",
        "sprouts" : "https://shop.sprouts.com/search?search_term={}&search_is_autocomplete=false",
        "trader" : "https://www.traderjoes.com/home/search?q={}&global=yes",
        "th" : "https://thangs.com/search/{}",
        "w" : "https://en.wikipedia.org/w/index.php?search={}&title=Special%3ASearch&go=Go&ns0=1",
        "x" : "https://xo.wtf/search?q={}&category_general=1&language=en-US&time_range=&safesearch=1&theme=simple", # searX
        "yt" : "https://piped.video/results?search_query={}",
        "yx" : "https://yandex.com/search/?text={}",
}

# SHORTCUTS
    # mpv - these work but are restricted by my mpv config being trash - videos spend eternity buffering and is unwatchable in current state
config.bind('em', 'hint links spawn nohup mpv --cache=yes --demuxer-max-bytes=300M --demuxer-max-back-bytes=100M -ytdl-format="bv[ext=mp4]+ba/b" --force-window=immediate --fs=yes {hint-url}')
#config.bind("eM", 'spawn nohup mpv {url}')
    # youtube-dl
config.bind("gyv", "spawn sh -c \"notify-send 'Downloading video...' '{url}' && yt-dlp '{url}' -P /home/$USER/Videos/ && notify-send 'Download complete!' '{url}' || notify-send 'Download failed...' '{url}' \"")
config.bind("gya", "spawn sh -c \"notify-send 'Downloading audio...' '{url}' && yt-dlp -f bestaudio '{url}' -P /home/$USER/Music/ && notify-send 'Download complete!' '{url}' || notify-send 'Download failed...' '{url}'\"")
    # generate qr code
config.bind("gqr", 'spawn link2qr {url}')
    # edit config
config.bind("ec", "config-edit")
    # zoom
config.bind("+", "zoom-in")
config.bind("-", "zoom-out")
    # enable/disable javascript
config.bind("sjt", "set content.javascript.enabled True ;; reload")
config.bind("sjf", "set content.javascript.enabled False ;; reload")
    # web archive
config.bind("wa", "open -t https://web.archive.org/web/{url}")
    # change autoplay settings
config.bind("sat", "set content.autoplay True")
config.bind("saf", "set content.autoplay False")
#config.bind("wi", "devtools window")

# SYSTEM
c.downloads.location.directory = "~/Downloads"

# BROWSER
c.auto_save.session = True
c.editor.command = [ 'gnome-terminal', '--', 'vim', '--clean', '{}' ]
c.hints.chars = "asdfghjkl"
c.qt.force_software_rendering = "chromium"
c.scrolling.smooth = True
c.session.lazy_restore = True
#c.scrolling.bar = "never"

# STATUS BAR
c.statusbar.show = "always"
c.statusbar.widgets = ["keypress", "progress", "url", "scroll"]

# TABS
c.tabs.background = True
c.tabs.last_close = "default-page"
c.tabs.mousewheel_switching = False
#c.tabs.padding = {"bottom" : 5, "top" : 5, "left" : 5, "right" : 5 }
c.tabs.position = "left"
c.tabs.select_on_remove = "next"
c.tabs.show = "multiple"
c.tabs.title.format = "{audio} {current_title}"
c.tabs.width = "15%"

# CONTENT
c.content.autoplay = False
c.content.cookies.accept = "no-3rdparty"
c.content.cookies.store = True
c.content.default_encoding = "utf-8"
c.content.javascript.enabled = True

# DARK MODE
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
#c.colors.webpage.darkmode.algorithm = "lightness-hsl"
#c.colors.webpage.darkmode.algorithm = "brightness-rgb"
c.colors.webpage.darkmode.contrast = 0.5
c.colors.webpage.darkmode.threshold.text = 150
c.colors.webpage.darkmode.threshold.background = 205


# COLORS
# source: https://github.com/inv4d3r/qute-config/blob/master/config.py & minor changes made
c.colors.completion.fg = "gray"
# c.colors.completion.bg = "black"
# c.colors.completion.alternate.bg = "#282828"
c.colors.completion.category.fg = "gray"
c.colors.completion.category.border.top = "#282828"
c.colors.completion.category.border.bottom = c.colors.completion.category.border.top
c.colors.completion.item.selected.fg = "#1d2021"
c.colors.completion.item.selected.bg = "#a89984"
c.colors.completion.item.selected.border.top = "#282828"
c.colors.completion.item.selected.border.bottom = c.colors.completion.item.selected.border.top
c.colors.completion.match.fg = "#689d6a"
c.colors.completion.scrollbar.fg = c.colors.completion.fg
# c.colors.completion.scrollbar.bg = c.colors.completion.bg
c.colors.statusbar.normal.fg = "#a89984"
c.colors.statusbar.normal.bg = "#282828"
c.colors.statusbar.private.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.private.bg = "#666666"
c.colors.statusbar.insert.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.insert.bg = "#282828"
c.colors.statusbar.command.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.command.bg = c.colors.statusbar.normal.bg
c.colors.statusbar.command.private.fg = c.colors.statusbar.private.fg
c.colors.statusbar.command.private.bg = c.colors.statusbar.private.bg
c.colors.statusbar.caret.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.caret.bg = "#a89984"
c.colors.statusbar.caret.selection.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.caret.selection.bg = "#458588"
c.colors.statusbar.progress.bg = "#83a598"
c.colors.statusbar.url.fg = c.colors.statusbar.normal.fg
c.colors.statusbar.url.success.http.fg = "#a89984"
c.colors.statusbar.url.success.https.fg = "#689d6a"
c.colors.statusbar.url.error.fg = "#fb4934"
c.colors.statusbar.url.warn.fg = "#b16286"
c.colors.statusbar.url.hover.fg = "#458588"
c.colors.tabs.odd.fg = "#a89984"
c.colors.tabs.odd.bg = "#1d2021"
c.colors.tabs.even.fg = c.colors.tabs.odd.fg
c.colors.tabs.even.bg = c.colors.tabs.odd.bg
c.colors.tabs.selected.odd.fg = "#8ec07c"
#c.colors.tabs.selected.odd.bg = "#282828"
c.colors.tabs.selected.odd.bg = "#0f0f0f"
c.colors.tabs.selected.even.fg = c.colors.tabs.selected.odd.fg
c.colors.tabs.selected.even.bg = c.colors.tabs.selected.odd.bg
#c.colors.tabs.bar.bg = "#0f0f0f"
c.colors.tabs.bar.bg = "#282828"
c.colors.tabs.indicator.start = "#ebdbb2"
c.colors.tabs.indicator.stop = "#b16286"
c.colors.tabs.indicator.error = "#d65d0e"
c.colors.tabs.indicator.system = "rgb"
c.colors.hints.fg = "#fbf1c7"
c.colors.hints.bg = "#665c54"
c.colors.hints.match.fg = "#fe8019"
c.colors.downloads.bar.bg = "#3c3836"
c.colors.downloads.start.fg = "#ebdbb2"
c.colors.downloads.start.bg = "#d65d0e"
c.colors.downloads.stop.fg = c.colors.downloads.start.fg
c.colors.downloads.stop.bg = "#689d6a"
c.colors.downloads.system.fg = "rgb"
c.colors.downloads.system.bg = "rgb"
c.colors.downloads.error.fg = "#b1a191"
c.colors.downloads.error.bg = "#d79921"
#c.colors.webpage.bg = "#fbf1c7"
c.colors.webpage.bg = "#282828"
c.colors.keyhint.fg = "#d33682"
c.colors.keyhint.suffix.fg = "#2aa198"
c.colors.messages.error.fg = "#fdf6e3"
c.colors.messages.error.bg = "#dc322f"
c.colors.messages.error.border = "#fdf6e3"
c.colors.messages.warning.fg = "#859900"
c.colors.messages.warning.bg = "#fdf6e3"
c.colors.messages.warning.border = "#d47300"
c.colors.messages.info.fg = "#a89984"
c.colors.messages.info.bg = "#1d2021"
c.colors.messages.info.border = "#202020"
c.colors.prompts.fg = "#a89984"
c.colors.prompts.bg = "#282828"
c.colors.prompts.selected.bg = "#282828"

# FONTS
c.fonts.completion.entry = "12px Hack"
c.fonts.completion.category = "12px Hack"
c.fonts.debug_console = "12px Hack"
c.fonts.downloads = "12px Hack"
c.fonts.hints = "12px Hack"
c.fonts.keyhint = "12px Hack"
c.fonts.messages.info = "12px Hack"
c.fonts.messages.error = "12px Hack"
c.fonts.prompts = "12px Hack"
c.fonts.statusbar = "12px Hack"
