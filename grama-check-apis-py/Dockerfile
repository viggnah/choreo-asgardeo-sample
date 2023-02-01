FROM python:3.11.1-slim

WORKDIR /app

RUN apt-get -y update && apt-get install -y curl gnupg gcc build-essential

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# download appropriate package for the OS version
# Debian 11
RUN curl https://packages.microsoft.com/config/debian/11/prod.list  \
    > /etc/apt/sources.list.d/mssql-release.list
RUN exit
RUN apt-get -y update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

# Copy the rest of the application code
COPY . /app

COPY requirements.txt . 
RUN pip3 install -r requirements.txt

CMD [ "flask", "--app", "azure-sql-test.py", "--debug", "run", "--host=0.0.0.0", "--port=5100"]

# CMD ["python3", "azure-sql-test.py"]
