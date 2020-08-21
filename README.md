
# Demo: Find number of recipes in foodie.fi website

Demo project for running Robot Framework tasks in Docker and in GitHub Workflows.

## Background

Project is inspired by the [Mimmit Koodaa RPA summer challenge 2020](https://mimmitkoodaa.ohjelmistoebusiness.fi/blogi/rpa-summer-challenge/). 

Project demonstrates:
1. How to run Robot Framework Tasks using Docker without need to install Python and Robot Framework to a computer.
2. How to run Robot Framework Tasks in GitHub Workflow using GithubActions 

## Run Tasks locally using Docker

### Prerequisites

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop) if not installed
2. Place tasks to a folder `tasks`
3. Create folder `reports`

### Run Tasks locally using Docker

This approach works for all Robot Framework tasks/tests that utilise libraries pre-installed to the [ppodgorsek/robot-framework Docker container](https://hub.docker.com/r/ppodgorsek/robot-framework).

To run Tasks, paste following to a Mac/Linux terminal or Windows Powershell:

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tasks:/opt/robotframework/tests:Z \
    ppodgorsek/robot-framework:latest
```

Or to run tasks in this repository, use this command (command passes variable `RECIPE_TO_SEARCH` and mounts results file containing number of search results out of the container):

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tasks:/opt/robotframework/tests:Z \
    -v ${PWD}/reports/file://opt/robotframework/temp/reports/file/ \
    -e ROBOT_OPTIONS="--variable RECIPE_TO_SEARCH:pizza" \
    ppodgorsek/robot-framework:latest
```

## Github Actions

[Actions tab](https://github.com/laojala/rpa_challenge/actions) of this repository showcases GitHub Workflow. That runs RPA task that finds recipe on foodie.fi site and prints a number of results. Workflow is defined in a file [.github/workflows/trigger_search.yml](.github/workflows/trigger_search.yml)

## License

This project is licensed under the MIT License.

## Acknowledgments

* [https://github.com/ppodgorsek/docker-robot-framework](https://github.com/ppodgorsek/docker-robot-framework)

### Alternative Docker images

* [https://github.com/Yleisradio/docker-robotframework](https://github.com/Yleisradio/docker-robotframework)

