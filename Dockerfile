# our base image
FROM alpine:3.9							# /var/lib/docker/overlay2/6c58a0e71a6c

# Install python and pip
RUN apk add --update python3					# /var/lib/docker/overlay2/76aa620aa051

# upgrade pip
RUN pip3 install --upgrade pip					# /var/lib/docker/overlay2/36251c871d32

# install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/				# /var/lib/docker/overlay2/34286dfe5be5
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt	# /var/lib/docker/overlay2/25f1d58a9af9 	

# copy files required for the app to run
COPY app.py /usr/src/app/					# /var/lib/docker/overlay2/8d6707422006
COPY templates/index.html /usr/src/app/templates/		# /var/lib/docker/overlay2/57a7442806e2

# tell the port number the container should expose
EXPOSE 5000							# /var/lib/docker/overlay2/f7a1e473d439

# run the application
CMD ["python3", "/usr/src/app/app.py"]
