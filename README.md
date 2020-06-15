# docker-experiments
1. Docker
	- Namespacing - Isolating resources per process like hard disk area (Map Hardware segment for the process)
	- Control Groups - Used to limit hardware resource usage for a process
	- Both are using to acheive a Docker container with the help of Linux Virtual machine on Windows/Mac
	
2. docker run = docker create + docker start
	- docker create - copy the file system snapshot of the image to the drive for the container
		- docker create hello-world
		  4e0444bf53eb3d429b144fe9631ccc801821e75ef1dcfad572645274ede98939
		  
	- docker start  - executing the start up command
		- docker start -a 4e0444bf53eb3d429b144fe9631ccc801821e75ef1dcfad572645274ede98939
		  <command execution output>

3. docker ps
	- List running containers
	--all : List full history of container runs
	
4. docker start
	- restart an exited container(we can't change the startup command)
		- docker start 4e0444bf53eb : Start without the command execution output
		- docker start -a 4e0444bf53eb

5. Remove stoped containers
	- docker system prune
		- This will remove all stopped containers, networks, dangling images, build cache
		
6. Retrieving log outputs
	- docker create busybox echo hi there
	- docker start <container id from the above commmand>
	- docker logs <container id from of the started container>

7. Stopping containers
	- docker create busybox ping google.com
	- docker start <container id>
	- docker logs <container id> 
	- docker ps : Still up and running
	- docker stop <container id> : Send SIGTERM signal, graceful shutdown
	- docker kill <container id> : Send SIGKILL signal, abrupt shutdown
		- Note: docker stop will fall back to docker kill if the container is not stopped within 10 sec
	
8. Execute another command in running container - Multi-command containers
	- docker create redis
	- docker start <container id>
	- docker logs <container id>
	- docker ps
	- docker exec -it <container id> redis-cli(command to be executed)
		- Note: The -it flag is used to attach the stdin to the running process(-t is using to format the output better)
		
9. Start with shell
	- - docker run -it busybox sh
	
10. Star container in background
	- docker run -d <docker image>
	
10. Create custom docker image
	- Created Dockerfile in /mnt/c/Workspace/ubuntu/docker/redis-image/
	- docker build .
	- docker run <image id which you will get from the above command output>
	
11. Docker build process
	- Docker pull the base image
	- Run the next step in the pulled image temporary container(remove after the execution)
	- Save a snapshot of the file system after execution of the commmand, then it will continue
	- CMD won't execute while building the image instead it just set the startup command
	Imp:- When you rebuild an image the docker take the image from cache instead of running the command in a container if there is no change in the build process(it saves a lot of time)
	
12. Tagging an image
	- docker build -t musthafakdml/my-redis:latest .
	- docker run musthafakdml/my-redis
	
13. Docker commit 
	- You can create a container from a running container
	- docker run -it alpine sh
	- run apk add --upgrade redis
	- open another terminal and run docker ps and take the container ID
	- docker commit -c 'CMD ["redis-server"]' <container id>
	
14. Container port mapping
	- docker run -p <localhost port>:<container port> <image name>
	
15. Specify working directory
	- WORKDIR <path inside the container> 
	- If the path is not existing the docker will create it for us. All the commands will be running inside the container relative to it.



Docker compose
	- You can find a sample of docker compose file inside: /mnt/c/Workspace/ubuntu/docker-experiments/node-project
	- When you start containers using docker compose they will be created in the same network and they can communicate with each other by default
	
	1. Start docker containers
		- docker-compose up or docker-compose --build
	2. Start docker containers in background
		- docker-compose up -d
	3. Stop containers
		- docker-compose down
	4. We can specify the restart policy to a container if its crashed during execution
		- Policies are "no", always, on-failure and unless-stopped
	5. Check status of the containers
		- docker-compose ps


Notes:-
	1. We can minimize the rebuilds when we change the files by changing the order of the copying files to the container
		- First copy only the files which is really required to run necessory commands like install dependencies
		- At the end please copy all the files, this way we can reduce the number of rebuilds


==================== Docker project =======================
- Small node js project inside a container -
  Source file: /mnt/c/Workspace/ubuntu/docker/node-project

	- cd /mnt/c/Workspace/ubuntu/docker/node-project
	- docker build -t musthafakdml/node-project .
	- docker run -p 8080:8080 musthafakdml/node-project
- We can change the copy order to minimize rebuilds and cache busting

