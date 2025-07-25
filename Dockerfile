#base image for a Python application
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg2 curl && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm google-chrome-stable_current_amd64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /app


#intall chrome driver
RUN CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | cut -d '.' -f 1) && \
    DRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION}") && \
    wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver && \
    rm /tmp/chromedriver.zip

#install dependencies
RUN pip install \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-jsonlibrary \
    selenium 

#copy the test files
COPY . /app

#run the tests
ENTRYPOINT ["robot", "-d", "reports", "tests/test.robot"]
