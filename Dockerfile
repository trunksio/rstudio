FROM centos

RUN yum update -y
RUN yum install -y wget python-pip vim tmux curl git bzip2 epel-release
RUN yum install -y unixODBC unixODBC-devel libxml2-devel libcurl-devel openssl-devel sssd-tools initscripts krb5-workstation krb5-libs krb5-auth-dialog enchant python-devel
RUN yum-builddep -y R
RUN wget https://cran.r-project.org/src/base/R-3/R-3.5.0.tar.gz
RUN tar -zxf R-3.5.0.tar.gz
WORKDIR R-3.5.0
RUN ./configure --enable-R-shlib --with-blas --with-lapack
RUN yum install -y make
RUN make 
RUN make install
WORKDIR / 
COPY install-packages.r /install-packages.r
RUN R -f /install-packages.r
RUN yum install -y udunits2-devel
COPY install-packages2.r /install-packages2.r
RUN R -f /install-packages2.r

COPY requirements.txt /requirements.txt
RUN yum install -y python-pip
RUN pip install -r /requirements.txt
EXPOSE 8787
COPY ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm
RUN yum install -y --nogpgcheck /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm
RUN python -m spacy download en
COPY installSpark.r /installSpark.r
RUN R -f /installSpark.r
RUN wget https://download2.rstudio.org/rstudio-server-rhel-pro-1.1.447-x86_64.rpm
RUN wget https://drivers.rstudio.org/7C152C12/odbc-install.sh
RUN yum install -y --nogpgcheck rstudio-server-rhel-pro-1.1.447-x86_64.rpm
RUN chmod +x odbc-install.sh
RUN ./odbc-install.sh
RUN rm /rstudio-server-rhel-pro-1.1.447-x86_64.rpm /ClouderaImpalaODBC-2.5.41.1029-1.el5.x86_64.rpm /odbc-install.sh

