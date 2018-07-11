.PHONY: scheduler_start scheduler_stop scheduler_nodetach dev_install
SHELL = /bin/bash

dev_install: ../ob-airtable  # Install project as library into current python and dependency if needed
	pip install -e .

scheduler_start: scheduler_stop  # Start scheduler in background
	mkdir -p var/logs
	luigid --background --pidfile var/luigid.pid --logdir var/logs/ --state-path var/luigid.state

scheduler_stop:  # Stop scheduler
	- killall luigid

scheduler_nodetach:  # run scheduler in foreground
	luigid --state-path var/luigid.state

../ob-airtable:  # Dependency which is not listened in setup.py
	git clone git@github.com:outlierbio/ob-airtable.git ../ob-airtable
	pip install -e ../ob-airtable
