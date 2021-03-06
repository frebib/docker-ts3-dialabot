FROM frebib/systemd:arch

RUN pacman -Sy --noc \
        xorg-server-xvfb x11vnc pulseaudio \
        teamspeak3 nss libxcursor libxcomposite && \
    pacman -Scc --noc
    
COPY *.service /etc/systemd/system/

    # Configure pulseaudio system mode
RUN systemctl enable pulseaudio && \
    useradd -r -U -G audio -m -d /var/run/pulse -c "PulseAudio" -s /bin/false pulse && \
    groupadd -r pulse-access && \
    \
    # Configure teamspeak user
    useradd -m -G pulse-access teamspeak && \
    systemctl enable teamspeak3 ts3vnc

ENV PULSE_RUNTIME_PATH=/var/run/pulse

VOLUME [ "/home/teamspeak/.ts3client" ]

