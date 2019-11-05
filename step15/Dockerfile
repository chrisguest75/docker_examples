FROM ubuntu:18.04 as sh 

WORKDIR /sh
RUN touch /sh/this_is_sh.txt
ENTRYPOINT ["/bin/sh"]

FROM ubuntu:18.04 as bash

WORKDIR /bash
RUN touch /bash/this_is_bash.txt

ENTRYPOINT ["/bin/bash"]

FROM ubuntu:18.04 as sh_cmd
WORKDIR /workspace

COPY show_processes.sh /workspace/show_processes.sh
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["/workspace/show_processes.sh"]

FROM ubuntu:18.04 as bash_cmd
WORKDIR /workspace

COPY show_processes.sh /workspace/show_processes.sh
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/workspace/show_processes.sh"]