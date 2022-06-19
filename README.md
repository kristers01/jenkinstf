# Jenkins AWS cloud formation updater / git merge reverter
#### This project allows you to revert a merge into main in this [repository.](https://github.com/kristers01/ubiquitous-spoon)
#### Or create / update a cloudformation stack with [first_stack.yaml](https://github.com/kristers01/ubiquitous-spoon/blob/main/first-stack.yaml)
## How it works
1. Launching project with terraform creates an EC2 instance which has access to S3, ECR and EC2. Outputs public IP.
2. The EC2 instance executes a script that installs git and docker, logs into ECR with docker and pulls a jenkins image with needed plugins.
3. Runs the jenkins docker container on port 8080
4. Copies a configured jenkins job from S3 and restarts the docker container.
5. Update webhook at [ubiquitous-spoon](https://github.com/kristers01/ubiquitous-spoon/settings/hooks) with the public IP of the EC2 instance.
6. When [ubiquitous-spoon](https://github.com/kristers01/ubiquitous-spoon) recieves a merge request into main branch it triggers the jenkins job.
7. Jenkins requests user input to proceed with the job or abort it.
8. Proceeding with the job updates or creates a cloudformation stack using [first_stack.yaml](https://github.com/kristers01/ubiquitous-spoon/blob/main/first-stack.yaml)
9. Aborting the job reverts the latest merge into main at [ubiquitous-spoon](https://github.com/kristers01/ubiquitous-spoon)
## Visual architecture representation
![architecture drawio](https://user-images.githubusercontent.com/97505081/174489630-b048f116-12a9-40af-a8af-2a29025b9e7e.png)
