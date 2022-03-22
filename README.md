# This is a template data science project
## Structure
- .github : This folder contains the workflow to execute upon pushing to github
in our case execute the test suite.
- deployment : This folder contains the the files for deploying the model to an
API endpoint from a docker container.
- main : This folder is where the main .py files you create for the project will
go
- tests : This folder is where the test suite will go.
- .gitignore : This file contains the instructions about what files git should not
track.
- LICENCE.txt : This file contains the licence for the project feel free to reuse it
or use a licence of your own choice.
- Makefile : Makefile to execute the tests and some cleaning functions.
- README.md : What you are currently reading update it to fit your own project.
- requirements.txt : The requirements of the project.
- setup.py : The setup file to allow the project to be installed.
## Setup
### Clone
To load the template on to your machine without git. Go to the directory you would
like the project to be in.
```bash
gh repo clone ogiles1999/example-project-template \
&& cd example-project-template && rm -rf .git \
&& tree -a
```
This clones the repo, deletes the .git folder and executes tree so you can see the
structure of the files in the repo.

### TDD (Optional)
If you are not interested in using TDD (test driven development during the project)
execute this command as well otherwise move onto data collection.
```bash
rm -rf .github && rm -rf tests
```

## Data collection