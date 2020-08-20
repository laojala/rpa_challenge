
# Demo: Robot Framework Selenium Automaton Using Docker

Demo project for running Robot Framework tasks in Docker and in GitHub Workflows.

## Run Tests locally

### Prerequisites

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) 
2. Place robot tests/tasks to a folder `tasks`
3. Create folder `reports`

## Run Robot Framework tasks/tests

Run command (in Mac/Linux terminal or Windows Powershell):

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tasks:/opt/robotframework/tests:Z \
    ppodgorsek/robot-framework:latest
```

Or to run tasks in this repository, use command (this passes variable `RECIPE_TO_SEARCH` and mounts results file containing number of searh results out of the container):

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tasks:/opt/robotframework/tests:Z \
    -v ${PWD}/reports/file://opt/robotframework/temp/reports/file/ \
    -e ROBOT_OPTIONS="--variable RECIPE_TO_SEARCH:pizza" \
    ppodgorsek/robot-framework:latest
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [https://github.com/ppodgorsek/docker-robot-framework](https://github.com/ppodgorsek/docker-robot-framework) 