FROM bash:5.0.17 as fewlayers

WORKDIR /workspace

#RUN /usr/local/bin/bash -c "for i in \{000..100\}; do echo \"hello\" > \"file\$\{i\}.txt\"; done"
#RUN /usr/local/bin/bash -c "for i in {000..100}; do echo "hello" > "file${i}.txt"; done"

#RUN echo "#!/usr/bin/env bash\nfor i in {000..200}; do echo \"hello\" > "file\${i}.txt"; done" > create_files.sh
#RUN chmod +x create_files.sh
#RUN ./create_files.sh 1000


COPY time-it.sh ./ 
#RUN echo "for i in {000..200}; do echo \"hello\" > "file\${i}.txt"; done" > create_files.sh

RUN echo $'\n\
#!/usr/local/bin/bash\n\
start=$RANDOM\n\
count=$(( $start + $1 )) \n\
for i in $(seq $start $count);\n\ 
do\n\ 
    echo "hello" > "file${i}.txt";\n\ 
done\n\
' >>  ./create_files.sh

RUN chmod +x create_files.sh
RUN /usr/local/bin/bash -c ". ./create_files.sh 3000"
RUN echo $'\n\
count=200\n\
if [[ -n $1 ]]; then\n\
    count=$1\n\
fi\n\
function find_files() {\n\
    find / | wc -l    \n\
 } \n\
. ./time-it.sh find_files $count \n\
' >> ./run_test.sh
RUN chmod +x ./run_test.sh

CMD ["/usr/local/bin/bash", "-c"]

FROM fewlayers as manylayers
RUN rm -f *.txt
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
RUN /usr/local/bin/bash -c ". ./create_files.sh 100"
