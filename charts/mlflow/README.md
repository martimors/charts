# mlflow

![Version: 0.4.2](https://img.shields.io/badge/Version-0.4.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.26.0](https://img.shields.io/badge/AppVersion-1.26.0-informational?style=flat-square)

A Helm chart for MLflow (https://mlflow.org/)

**Homepage:** <https://github.com/dingobar/charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Martin Morset |  | <https://github.com/dingobar> |

## Source Code

* <https://github.com/dingobar/charts>
* <https://github.com/dingobar/images>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | minio | 11.5.1 |
| https://charts.bitnami.com/bitnami | postgresql | 11.2.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity) |
| artifactStore.defaultArtifactRoot | string | `""` | Where to write/read artifacts, see the mlflow docs for options. Recommended to use S3 or S3 compatible blob storage. If left blank, artifacts are saved locally in the image and not persisted. |
| artifactStore.s3EndpointUrl | string | `""` | If you use a non-AWS S3 host such as MinIO, specify the URI here |
| backendStore.backendStoreUri | string | `"file:///opt/mlflow/mlruns"` | The [SQLAlchemy URI](https://docs.sqlalchemy.org/en/14/core/engines.html#database-urls) of the backend store to use (if sqlite is chosen, it is auto-created in the container and does not persist) |
| backendStore.backendStoreUriExistingSecret | string | `nil` | Existing secret name and key to get the backendStoreUri from (name: foo, key: bar) |
| extraEnv | object | `{}` | Extra environment variables to include in the mlflow pods, in the form of key: value pairs (for example, `FOO: bar`) |
| extraEnvFrom | string | `nil` | Extra secrets or configmaps to get env-variables from |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | See [the kubernetes docs](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy) |
| image.repository | string | `"dingobar/mlflow"` | Image to use for deploying, must support ENTRYPOINT[ "mlflow", "server" ] |
| image.tag | string | `"1.26.0-3.10-slim-bullseye"` | Tag of the image to use |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` | Ingress annotations in the form of key: value |
| ingress.create | bool | `false` | Whether or not an Ingress resource is created (only the `networking.k8s.io/v1` API is supported) |
| ingress.hosts | list | `[]` | List of hosts in the form [{name: foo}, {name: bar, tls: {enabled: true, secretName: my-secret}}, ...] |
| ingress.path | string | `"/"` | Ingress path |
| ingress.pathType | string | `"Prefix"` | Ingress path type, see [the Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/ingress/#path-types) for possible values |
| minio.auth.rootPassword | string | `"mlflow-secret"` |  |
| minio.auth.rootUser | string | `"mlflow-key"` |  |
| minio.defaultBuckets | string | `"mlflow"` |  |
| minio.enabled | bool | `true` | Whether to deploy the MinIO subchart (recommend using external S3 such as AWS S3 in production) |
| minio.persistence.enabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) |
| podAnnotations | object | `{}` | Extra annotations for all pods |
| podSecurityContext | object | `{}` | Security context for the pods. The default container can run as any user/group and does not run with elevated access |
| postgresql.auth.database | string | `"mlflow"` |  |
| postgresql.auth.password | string | `"mlflow"` |  |
| postgresql.auth.username | string | `"mlflow"` |  |
| postgresql.enabled | bool | `true` | Whether to deploy the PostgreSQL subchart (highly recommended to use a managed database service such as AWS RDS in production) |
| prometheus.expose | bool | `false` | If `true`, prometheus metrics are exposed on /metrics |
| replicaCount | int | `1` | Number of replicas of mlflow server to run |
| resources | object | `{}` | Resource limits and requests for the mlflow pods |
| securityContext | object | `{}` | Security context for the individual containers. Take presedence over podSecurityContext. |
| service.port | int | `5000` |  |
| service.type | string | `"ClusterIP"` | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types) |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | See [the Kubernetes docs](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.9.1](https://github.com/norwoodj/helm-docs/releases/v1.9.1)
