# docker-kubernetes-helm

## Supported tags

- `latest`, `v2` (helm 2)
- `v3` (helm 3)

## Example

```yaml
...

deploy-staging:
  image: apliteni/kubernetes-helm:3
  stage: deploy
  before_script:
    - kubectl config set-cluster ${KUBE_NAME} ...
    - kubectl config set-credentials ${KUBE_USER} ...
    - kubectl config set-context ${KUBE_NAME}
        --cluster="${KUBE_NAME}"
        --user="${KUBE_USER}"
        --namespace="${KUBE_NAMESPACE}"
    - kubectl config use-context ${KUBE_NAME}
  script:
    - helm install release-name chart/name --namespace ${KUBE_NAMESPACE}

...
```

## License

[MIT](https://github.com/hypnoglow/docker-kubernetes-helm/blob/master/LICENSE).
