FROM python:3.11.1-slim

# ARG USERNAME=13100
# ARG USER_UID=12000
# ARG USER_GID=$USER_UID

# # Create a non-root user
# RUN groupadd --gid $USER_GID $USERNAME \
#     && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

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

# Switch to non-root user after doing all the root user stuff with apt-get
USER 13100

EXPOSE 5000

CMD [ "flask", "--app", "azure-sql-test.py", "run", "--host=0.0.0.0"]
# CMD [ "flask", "--app", "azure-sql-test.py", "--debug", "run", "--host=0.0.0.0", "--port=5100"]
# CMD ["python3", "azure-sql-test.py"]
