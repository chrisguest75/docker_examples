FROM docker:20.10.7-dind

WORKDIR /scratch


RUN apk update && apk add bash curl --no-cache  
RUN wget https://github.com/goodwithtech/dockle/releases/download/v0.3.15/dockle_0.3.15_Linux-64bit.apk && apk add --allow-untrusted dockle_0.3.15_Linux-64bit.apk
RUN wget https://github.com/wagoodman/dive/releases/download/v0.10.0/dive_0.10.0_linux_amd64.tar.gz && tar -xzvf dive_0.10.0_linux_amd64.tar.gz && mv dive /bin/



