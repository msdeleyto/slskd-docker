FROM slskd/slskd:0.25.1@sha256:ab9ed50e028b524cefdb7c1dd8ebca368a076e18441ee8ac2326473eb850b4c3

RUN apt update

# Install clamav
RUN apt install clamav clamav-daemon -y

# Install ssmtp and mailutils
RUN apt install ssmtp mailutils -y

# Install python3
RUN apt install python3 -y

COPY files/scan_file.py /scan_file.py
RUN chmod +x /scan_file.py

COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /slskd

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]
