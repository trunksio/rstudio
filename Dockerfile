FROM centos

RUN yum update -y
RUN yum install -y wget python-pip vim tmux curl git bzip2 epel-release
RUN yum install -y R unixODBC unixODBC-devel libxml2-devel libcurl-devel openssl-devel sssd-tools initscripts krb5-workstation krb5-libs krb5-auth-dialog enchant python-devel
COPY install-packages.r /install-packages.r
RUN R -f /install-packages.r
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
EXPOSE 8787
RUN wget https://download2.rstudio.org/rstudio-server-rhel-1.1.383-x86_64.rpm
RUN yum install -y --nogpgcheck rstudio-server-rhel-1.1.383-x86_64.rpm
COPY ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm
RUN yum install -y --nogpgcheck /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm
RUN python -m spacy download en
COPY installSpark.r /installSpark.r
RUN R -f /installSpark.r
RUN rm /rstudio-server-rhel-1.1.383-x86_64.rpm /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm

