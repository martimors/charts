# Helm Charts

This is where I keep my helm charts!

Contributions welcome.

See also [the images](https://github.com/dingobar/images).

Currently, the available charts are:

- [MLflow](./charts/mlflow/README.md): MLflow chart with built-in functional tests and
  MinIO/PostgreSQL subcharts for testing purposes

## Install a chart

Assuming you have [Helm](https://helm.sh/) installed,

```sh
helm repo add dingobar https://dingobar.github.io/charts/
helm upgrade --cleanup-on-fail --install -n mlflow --create-namespace my-mlflow dingobar/mlflow
```

For customization options, see the README.md for [each chart](./charts/).

## docs

We generate docs using [helm-docs](https://github.com/norwoodj/helm-docs). I recommend using the
pre-commit hook. See the [pre-commit config file](./.pre-commit-config.yaml) for details.

```sh
pip3 install --upgrade pre-commit
pre-commit install
```

## Improvement ideas

- Add MinIO and PostgreSQL sub-charts for testing
- CI pipeline that runs helm tests
- Better test for mlflow (maybe log an artifact or something?)
