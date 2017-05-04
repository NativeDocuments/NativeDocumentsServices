# To build it manually:
# sudo docker build -t nativedocumentsservices .
# sudo docker run -d -P --name nds nativedocuments/nativedocumentsservices
# sudo docker run -d -p 9015:9015 -v ~/nds.license:/opt/NativeDocumentsRenderer/nds.license --name nds nativedocuments/nativedocumentsservices
# test: curl -X POST --data-binary @border03.docx -o out.pdf http://127.0.0.1:9015/v1/00000000-0000-0000-0000-000000000000/convert

FROM busybox:musl
ADD http://downloads.nativedocuments.com/NativeDocumentsRenderer-2.0-25.tar.gz /tmp/
RUN mkdir /opt
RUN tar xzf /tmp/NativeDocumentsRenderer-2.0-25.tar.gz -C /opt
RUN rm -f /tmp/NativeDocumentsRenderer-2.0-25.tar.gz
# OPTIONAL: add hyphenation dictionaries
ADD http://downloads.nativedocuments.com/dict/hyph_en_US.dic /opt/NativeDocumentsRenderer/
ADD http://downloads.nativedocuments.com/dict/hyph_de_DE.dic /opt/NativeDocumentsRenderer/
RUN mkdir -p /opt/NativeDocumentsRenderer/log
RUN mkdir -p /opt/NativeDocumentsRenderer/tmp
ENV NDS_LOG_FILE=/dev/stdout
ENV NDS_LOG_DIR=/opt/NativeDocumentsRenderer/log
ENV NDS_BASE_DIR=/opt/NativeDocumentsRenderer/tmp
ENV NDS_LICENSE=/opt/NativeDocumentsRenderer/nds.license
ENV NDS_VERBOSE=0
ENTRYPOINT ["/opt/NativeDocumentsRenderer/ndrenderd", "service=0.0.0.0:9015"]
EXPOSE 9015
