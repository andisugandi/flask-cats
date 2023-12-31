FROM alpine:3.12
RUN apk update \
    && apk --no-cache add python3 cmd:pip3
RUN pip3 install --upgrade pip
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
COPY app.py /usr/src/app/		
COPY templates/index.html /usr/src/app/templates/
EXPOSE 5000
CMD ["python3", "/usr/src/app/app.py"]
