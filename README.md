# Norden Core Services - Backend

## Ruby and rails versions
* **Rails 7.0.2**
* **Ruby 3.1.1**

## System dependencies

## Configuration

## Database
### Creation
### Initialization

## Testing

## Services (job queues, cache servers, search engines, etc.)

## Deployment


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

