// ==UserScript==
// @name 	Youtube redirector
// @namespace 	My userscripts
// @match 	http://www.youtube.com/*
// @match 	https://www.youtube.com/*
// @match 	http://youtu.be/*
// @match 	https://youtu.be/*
// @run-at 	document-start
// ==/UserScript==

//Piped has been less reliable lately, using invidious instead now
//location.href=location.href.replace("www.youtube.com","piped.kavin.rocks")
location.href=location.href.replace("www.youtube.com","yewtu.be")
