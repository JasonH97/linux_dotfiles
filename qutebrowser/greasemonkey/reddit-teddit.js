// ==UserScript==
// @name 	Reddit to Teddit redirector
// @namespace 	My userscripts
// @match	http://reddit.com/*
// @match	https://reddit.com/*
// @match	http://www.reddit.com/*
// @match	https://www.reddit.com/*
// @run-at 	document-start
// ==/UserScript==

location.href=location.href.replace("www.reddit.com","teddit.net")
