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

### Create the env file
Copy the contents of `.env.dev` and paste them into a new file called `.env.dev.local`.

### Load the containers
Since Docker loads all the dependencies as containers, all you have to do is clone the repo and run 
```console
docker-compose run core-backend sh -c “./bin/setup”
```
and then:
```console
docker-compose --env-file .env.dev.local up core-backend
```
That will fetch you rails, redis, postgres, rabbitMQ, sidekiq, download and install the needed gems, setup the DB and prepare the ground for the backend and frontend projects.

### Set the data up
**_This step is only necessary if you could not create the DB with the first command from the section above._**

While the container is running, in another console prompt, run 
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
You should be ready to go! Below you can find some [docker commands](https://git.michelada.io/norden/core-backend/-/wikis/Docker) that might prove useful in your development process.
If you need the **master.key** or need help with anything else please reach out to the team.

### Best practices
Check out our [gitflow styleguide](https://git.michelada.io/norden/core-backend/-/wikis/Gitflow) on creating well-named branches and writing good commits before adding your code.

## Testing
**Soon**

## Services (job queues, cache servers, search engines, etc.)
**Soon**

## Deployment
**Soon**
