# Charts

This is where I keep my helm charts!

Contributions welcome.

## Install

Currently the chart can only be installed directly from the repo.

For example, to install mlflow,

```sh
cd mlflow
helm upgrade --install -n mlflow --create-namespace mlflow .
```

## docs

We generate docs using [helm-docs](https://github.com/norwoodj/helm-docs). I recommend using the pre-commit hook.
See the [pre-commit config file](./.pre-commit-config.yaml) for details.

```sh
pip3 install --upgrade pre-commit
pre-commit install
```

## Improvement ideas

- Publish to helm chart repo on github pages
- Include an ingress resource
- Add MinIO and PostgreSQL sub-charts for testing
- CI pipeline that runs helm tests
- Better test for mlflow (maybe log an artifact or something)
