# sudo docker build -t nativedocumentsservices .
# sudo docker run -d -P --name nds nativedocumentsservices

FROM ubuntu
ADD http://nativedocuments.wordsdk.com/downloads/NativeDocumentsServices.initd.x86_64.deb /tmp/
RUN dpkg -i /tmp/NativeDocumentsServices.initd.x86_64.deb && rm /tmp/NativeDocumentsServices.initd.x86_64.deb
ENV NDS_LOG_DIR=/var/log/NativeDocumentsServices
ENV NDS_LOG_FILE=/dev/stdout
ENV NDS_LICENSE=/opt/NativeDocumentsServices/nds.license
ENV NDS_VERBOSE=1
ENTRYPOINT ["/opt/NativeDocumentsServices/ndsd", "service=0.0.0.0:9015"]
EXPOSE 9015
