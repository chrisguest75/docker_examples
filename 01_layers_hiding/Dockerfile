FROM scratch
ENV mysecret notasecret

COPY file1.txt file1.txt
# overwrite file1.txt in next layer
COPY file2.txt file1.txt
# overwrite file1.txt again in another layer
COPY file3.txt file1.txt
# copy file2 and file3
COPY file2.txt file2.txt
COPY file3.txt file3.txt
