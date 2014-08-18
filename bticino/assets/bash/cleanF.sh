while :
do
	echo '{"content": "' > /home/pi/bticino/assets/bash/lastCommands.json
	cat /home/pi/bticino/assets/bash/serialContent.json >> /home/pi/bticino/assets/bash/lastCommands.json
	echo '"}' >> /home/pi/bticino/assets/bash/lastCommands.json
	cat /home/pi/bticino/assets/bash/lastCommands.json |tr -d "\n" > /home/pi/bticino/assets/bash/serialF.json
	sleep 2
done
