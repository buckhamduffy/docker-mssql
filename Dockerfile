FROM mcr.microsoft.com/mssql/server:2017-latest

# Create a config directory
RUN mkdir -p /usr/config
WORKDIR /usr/config

# Bundle config source
COPY . /usr/config

# Grant permissions for to our scripts to be executable
RUN chmod +x /usr/config/entrypoint.sh
RUN chmod +x /usr/config/configure-db.sh

RUN /opt/mssql/bin/mssql-conf traceflag 3979 on && \
        /opt/mssql/bin/mssql-conf set control.alternatewritethrough 0 && \
        /opt/mssql/bin/mssql-conf set control.writethrough 0

ENTRYPOINT ["./entrypoint.sh"]