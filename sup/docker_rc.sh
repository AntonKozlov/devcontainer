
if [ ! $(docker ps -q -f "name=$DC_NAME") ]; then
	echo "WARNING: No running container named \"$DC_NAME\" found!"
	echo "Define DC_NAME variable to set target container."
fi

dr() {
	local tty_opt=
	[ -t 0 ] && tty_opt="-t"

	docker exec \
		-u user \
		-i \
		$tty_opt \
		${DC_DETACH_KEY:+--detach-keys $DC_DETACH_KEY } \
		$DC_NAME \
		bash -lc "$*"
}
