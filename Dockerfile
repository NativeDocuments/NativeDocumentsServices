# To build it manually:
# sudo docker build -t nativedocumentsservices .
# sudo docker run -d -P --name nds nativedocumentsservices
# sudo docker run -d -p 9015:9015 -v ~/nds.license:/opt/NativeDocumentsServices/nds.license --name nds nativedocumentsservices

FROM ubuntu
ADD http://downloads.nativedocuments.com/NativeDocumentsServices-2.0-3.initd.x86_64.deb /tmp/
RUN dpkg -i /tmp/NativeDocumentsServices-2.0-3.initd.x86_64.deb && rm /tmp/NativeDocumentsServices-2.0-3.initd.x86_64.deb
ENV NDS_LOG_DIR=/var/log/NativeDocumentsServices
ENV NDS_LOG_FILE=/dev/stdout
ENV NDS_LICENSE=/opt/NativeDocumentsServices/nds.license
#ENV NDS_VERBOSE=1
ENTRYPOINT ["/opt/NativeDocumentsServices/ndsd", "service=0.0.0.0:9015"]
EXPOSE 9015
