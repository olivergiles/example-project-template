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

## Data Collection

### Collection
The first step of any project is data collection. Any source will work but in order
to practice using GCP and SQL I would recommend using Big Query. Go to big query. And find a dataset that interest you and extract the important data using SQL.
Below is an example query which pulls out some data about stackoverflow posts.
The idea for this data is to try and work out what makes a post likely to recieve
an answer.
```code
SELECT title
, LENGTH(title) AS title_length
, body
, LENGTH(body) AS body_length
, answer_count
, score
, (LENGTH(tags) - LENGTH(REPLACE(tags, "|", "")) + 1) AS num_tags
FROM `bigquery-public-data.stackoverflow.stackoverflow_posts`
LIMIT 10000
```
Once you have a query if you are using Big Query here is the code to use the python
API to download it into a csv.
```code
import subprocess
import pandas as pd

def main():
    """a function to use a big query query to make a csv"""
    cmd = ("""bq --format=csv query \
    --max_rows=10000 \
    --use_legacy_sql=false \
    '
    SELECT title
    , LENGTH(title) AS title_length
    , body
    , LENGTH(body) AS body_length
    , answer_count
    , score
    , (LENGTH(tags) - LENGTH(REPLACE(tags, "|", "")) + 1) AS num_tags
    FROM `bigquery-public-data.stackoverflow.stackoverflow_posts`
    LIMIT 10000
    ' > output.csv
    """)
    subprocess.call(cmd, shell=True)
    return None

if __name__ == "__main__":
    main()
    df = pd.read_csv("output.csv")
    print(df.shape)
    print(df.head())
```

## Git

Now that you have a topic and goal of the project time to name the repo and create it on github. To rename the folder.
```bash
mv example-project-template <your new name>
```
Then enter your project create a repo.
```bash
cd <your new name> && \
git init
```
Once you have created a repo add what you have done so far
```bash
git add .
```
Then make commits but make sure to seperately commit files and explain what they are.
```bash
git commit <file> -m "comment"
```
Finally connect the repo to github. In order for the tests to work if you are using
TDD make sure to update .github/workflow/pythonpackage.yml to match what your main
branch is called.
```bash
gh repo create
```
And push what you have done so far!
## Data Storage
Now that you have your data in your repo it is important to either track it
using git lfs or add it to the .gitignore so that you do not attempt to push it to
github.

## Data Cleaning

Now over to you to clean up the data ready to build a model here build up a pipeline
to clean your data into a format usable by a model. Then turn it into a .py file.
If you are doing TDD now is a good time to write a test to check that the pipeline
is tranforming the data in the way that you expect.

## Model building

Now time to create a model for your data. Here I would recommend building a simple model that works completing the rest of the steps and then coming back to tune. Write a script that loads your model as well ready to make a prediction.

## Deployment

Now move everything you need to make a prediction into deployment/api. Make sure
to updated requirements.txt to include the packages you need. Make sure to update
the Makefile with what you want to call your DOCKER_IMAGE_NAME and GCP details if you
wish to deploy to GCP. Finally integrate your model predcition into api/app.py. Below is an example predict endpoint.
```code
@app.get("/predict")
def question(params):
    model = <YOUR MODEL>
    answer = model.predict(params)
    return {"answer": answer}
```
Now to run the api locally to test:
build the docker container
```bash
make build_container
```
then launch the api
```bash
make run_container
```
You should now have a working api using your model at localhost:8000

## Finishing touches

- Update the readme to explain your project and how to use it on github!
- Tune the model
- End a front end using streamlit