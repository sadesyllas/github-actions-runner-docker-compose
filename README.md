# github-runner-docker-compose

1. Copy file `.env.template` to create file `.env`.
3. Setup the necessary environment variables in file `.env`.
4. Run
   ```bash
   ./up.sh -d
   ```
   or
   ```bash
   DOCKER_GROUP_ID=$(stat -c %g /var/run/docker.sock) docker-compose up -d
   ```
   to start the runner service in the background
   (remove the `-d` option to run it in the foreground).
