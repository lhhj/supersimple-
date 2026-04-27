# 🚀 supersimple - Hello World for HPE PCAI

A minimal Hello World web app containerised with Docker, packaged as a Helm chart, and deployed to HPE Private Cloud AI (PCAI).

## Project Structure

```
supersimple/
├── index.html                          # Static web page
├── Dockerfile                          # Container definition (nginx:alpine)
├── .github/
│   └── workflows/
│       └── build.yml                   # CI/CD pipeline
└── helm/
    └── helloworld/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── _helpers.tpl
            ├── deployment.yaml
            ├── service.yaml
            └── ingress.yaml
```

## CI/CD Pipeline

On every push to `main` or a version tag (`v*.*.*`), GitHub Actions will:

1. **Build** the Docker image
2. **Push** it to Docker Hub as `YOUR_DOCKERHUB_USER/helloworld`
3. **Package** the Helm chart as a `.tgz` file
4. **Upload** the `.tgz` as a GitHub Actions artifact (and as a GitHub Release asset on tags)

## Required GitHub Secrets

Go to **Settings → Secrets and variables → Actions** in your GitHub repo and add:

| Secret | Value |
|--------|-------|
| `DOCKERHUB_USERNAME` | Your Docker Hub username |
| `DOCKERHUB_TOKEN` | Your Docker Hub access token (not password!) |

> Create a Docker Hub token at: https://hub.docker.com/settings/security

## Deploy to PCAI

### Install from Helm .tgz

Download the `.tgz` from GitHub Actions artifacts or the Release page, then:

```bash
helm install helloworld ./helloworld-0.1.0.tgz \
  --set image.repository=YOUR_DOCKERHUB_USER/helloworld \
  --set image.tag=latest
```

### Upgrade

```bash
helm upgrade helloworld ./helloworld-0.1.0.tgz \
  --set image.tag=sha-abc1234
```

### Uninstall

```bash
helm uninstall helloworld
```

## Access the App

Once deployed, visit:

```
https://home.ai-application.pcai.danofficeit.com/helloworld
```

## Tagging a Release

```bash
git tag v1.0.0
git push origin v1.0.0
```

This triggers a full pipeline build and creates a GitHub Release with the `.tgz` attached.
