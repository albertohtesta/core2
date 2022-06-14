# Norden Core Services - Backend

## System dependencies
* Docker (If you are on macOS use the desktop version 😁)
* Ruby 3.1.1
* Rails 7.0.2

## Configuration
Please follow the steps below in the order they are presented.

### Initialization of the frontend submodule
The core-frontend project has been added as a git submodule to be used within this project. Please run 
```console
git submodule update --init --recursive
```
in the root path to clone the project locally. **DO NOT** clone it manually.

### Load the containers
Since Docker loads all the dependencies as containers, all you have to do is clone the repo and run 
```console
docker-compose up --build
```
That will fetch you rails, redis, postgres, rabbitMQ, sidekiq and prepare the ground for the backend and frontend projects.

### Set the data up
Now, in another console prompt, run 
```console
docker-compose exec core-backend sh
```
to bring up the **core-backend** container shell. Inside the shell, create the development and testing databases with 
```console
rails db:init
```
and then run the migrations with 
```console
rails db:migrate
```
Leave the shell with `exit`.

### Finishing steps
You should be ready to go! Below you can find some [docker commands](#docker) that might prove useful in your development process.
If you need the **master.key** or need help with anything else please reach out to the team.

## Testing
**Soon**

## Services (job queues, cache servers, search engines, etc.)
**Soon**

## Deployment
**Soon**


## Docker
 Here you will find a listing of the commands that are mostly used project-wide.

### Docker commands
 * Get a list of the current images in the system
 ```console
 docker container ls
 ```
 or
 ```console
 docker ps
 ```

 * Get a list of the current images in the system
  ```console
  docker image ls
  ```

 * Remove all stopped containers, all networks not used by at least one container, all dangling images and all dangling build cache. Useful for clearing the cache when a change is not being shown. REMEMBER THIS IS A DANGEROUS ACTION.
  ```console
  docker system prune
  ```

 * Remove all local volumes not used by at least one container. REMEMBER THIS IS A DANGEROUS ACTION.
  ```console
  docker volume prune
  ```

### Docker Compose commands
 * Runs the docker defined in the `docker-compose.yml` in the current directory. If it is its first time running, it will first build the image.
  ```console
  docker-compose up
  ```

 * Runs the docker defined in the `docker-compose.yml` in the current directory and forefully rebuilds the image. Useful for situations when you made changes to the composition of the `docker-compse.yml` or the `Dockerfile` itself. 
  ```console
  docker-compose up --build
  ```

 * Shuts the containers down and removes them.
  ```console
  docker-compose down
  ```
 * Shows a list of stored containers, their status and where are they defined.
  ```console
  docker-compose ls
  ```
 * Get access to the desired app within a container and execute the specified command.
  ```console
  docker-compose exec <APP_NAME OR APP_ID> <COMMAND>
  ```

