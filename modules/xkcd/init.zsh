# View Xkcd comics: OH YEAH!
function xkcd() {
	local comic="$1"
	local xkcdurl
	if [[ $comic == "random" ]]; then
		xkcdurl="http://dynamic.xkcd.com/comic/random/"
	else
		xkcdurl="http://xkcd.com/${comic// /+}"
	fi
	wget -qO- ${xkcdurl}|tee >(feh $(grep -Po '(?<=")http://imgs[^/]+/comics/[^"]+\.\w{3}'))|grep -Po '(?<=(\w{3})" title=").*(?=" alt)';
}
