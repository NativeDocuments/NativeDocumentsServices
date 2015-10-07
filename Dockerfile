# sudo docker build -t nativedocumentsservices .
# sudo docker run -d -P --name nds nativedocumentsservices

FROM ubuntu
ADD http://nativedocuments.wordsdk.com/downloads/NativeDocumentsServices.initd.x86_64.deb /tmp/
RUN dpkg -i /tmp/NativeDocumentsServices.initd.x86_64.deb && rm /tmp/NativeDocumentsServices.initd.x86_64.deb && sudo initctl stop NativeDocumentsServices && sudo sed 's/^NDS_SERVICE_ARGS=.*$/NDS_SERVICE_ARGS=0.0.0.0:9015/g' -i /opt/NativeDocumentsServices/NativeDocumentsServices.config
CMD ["/opt/NativeDocumentsServices/ndsd", "service"]
EXPOSE 9015
