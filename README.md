# github-runner-docker-compose

1. Copy file `.env.template` to create file `.env`.
2. Create a `build` directory, to ensure that the runner can access it
   using your user and group ids.
3. Setup the necessary envirionment variables in file `.env`.
4. Run `./up.sh -d` or `USER_ID=$(id -u) GROUP_ID=$(id -g) docker-compose up -d`,
   to start the runner service in the background
   (remove the `-d` option to run it in the foreground).
