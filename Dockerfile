FROM ubuntu:18.04

ENV ACCEPT_EULA=Y

RUN export DEBIAN_FRONTEND=noninteractive && \
        apt-get update && \
        apt-get install -y curl gnupg && \
        curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
        curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2017.list | tee /etc/apt/sources.list.d/mssql-server.list && \
        curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/mssql-tools.list && \
        apt-get update && \
        apt-get install -y mssql-server-fts mssql-server mssql-tools && \
        # Cleanup the Dockerfile 
        apt-get remove -y gnupg curl && \
        apt-get clean autoclean && \
        apt-get autoremove --yes && \
        rm -rf /var/lib/{apt,dpkg,cache,log}

# Create a config directory
RUN mkdir -p /usr/config
WORKDIR /usr/config

# Bundle config source
COPY . /usr/config

# Grant permissions for to our scripts to be executable
RUN chmod +x /usr/config/entrypoint.sh
RUN chmod +x /usr/config/configure-db.sh

ENV MSSQL_PID=Developer

RUN /opt/mssql/bin/mssql-conf traceflag 3979 on && \
        /opt/mssql/bin/mssql-conf set control.alternatewritethrough 0 && \
        /opt/mssql/bin/mssql-conf set control.writethrough 0

ENTRYPOINT ["./entrypoint.sh"]