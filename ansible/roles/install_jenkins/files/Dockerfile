FROM jenkins/jenkins:2.207

USER root
RUN apt update && \
	apt install -y git curl ansible sshpass jq && \
	apt-get clean &&\
	rm -rf \
	/var/lib/apt/lists/* \
	/tmp/* \
	/var/tmp/* \
	/usr/share/man \
	/usr/share/doc \
	/usr/share/doc-base

# Install Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	apt update && \
	chmod +x /usr/local/bin/docker-compose && \
	ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
# RUN groupadd docker && \
# 	echo "jenkins       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
# 	echo "DOCKER_OPTS=' -G jenkins'" >> /etc/default/docker && \
# 	usermod -a -G docker jenkins

USER jenkins
RUN /usr/local/bin/install-plugins.sh \
	ansible \
	ghprb \
	github \
	locale \
	simple-theme-plugin
