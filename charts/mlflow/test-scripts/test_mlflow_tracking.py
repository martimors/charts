#!/usr/bin/env python3
"""Start a run, log params/metrics, and finally log an artifact"""
import mlflow
from pathlib import Path
from os import environ
import logging
from datetime import datetime, timezone

logging.basicConfig(format="%(asctime)s - %(levelname)s - %(module)s - %(message)s")
logging.getLogger().setLevel(logging.INFO)

# See https://github.com/mlflow/mlflow/issues/2564
environ["GIT_PYTHON_REFRESH"] = environ.get("GIT_PYTHON_REFRESH", "quiet")


def check_environment():
    # Check for required env-variables
    required_env_vars = ["MLFLOW_TRACKING_URI"]
    for env_var in required_env_vars:
        assert env_var in environ, f"{env_var} must be set for test to run!"


def create_dummy_text_file():
    with open(Path("test.txt"), "w") as file:
        file.write(f"Hello from the magical land of tests at {datetime.now(timezone.utc)}!")


def run_dummy_experiment():
    experiment = mlflow.set_experiment("test")
    with mlflow.start_run() as run:
        run_id = run.info.run_id
        create_dummy_text_file()
        mlflow.log_param("foo", "bar")
        mlflow.log_metric("baz", 1.2345)
        mlflow.log_artifact(str(Path("test.txt")))
    logging.info(
        "Successfully ran test, see output at "
        f" {environ['MLFLOW_TRACKING_URI']}/#/experiments/{experiment.experiment_id}/{run_id}"
    )


def main():
    logging.info(f"Starting test script {__file__}")
    check_environment()
    run_dummy_experiment()


if __name__ == "__main__":
    main()
