FROM jenkins/jenkins:lts

# Вимикаємо майстер початкового налаштування (щоб не просило пароль)
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Встановлюємо логін та пароль адміністратора (admin/admin)
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Копіюємо список плагінів та встановлюємо їх
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Копіюємо конфігурацію нашої Job
COPY config.xml /usr/share/jenkins/ref/jobs/hello-world/config.xml
