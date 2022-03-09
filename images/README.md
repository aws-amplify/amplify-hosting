<p align="center">
  <a href="https://console.amplify.aws">
    <img alt="Amplify" src="https://github.com/aws-amplify/community/blob/master/src/assets/images/logo-dark.png" width="60" />
  </a>
</p>
<h1 align="center">
  Amplify Hosting - Build Images
</h1>

<a href="https://docs.aws.amazon.com/amplify/latest/userguide/welcome.html">Amplify Hosting</a> provides 2 build images that are based on Amazon Linux. The latest build image is based on Amazon Linux 2, but we also provide the orginal build image that is based on Amazon Linux 1 for backwards compatibility. These images are used as defaults for builds in Amplify Console, we also provide the option to use a <a href="https://docs.aws.amazon.com/amplify/latest/userguide/custom-build-image.html#setup">custom image</a> however.

### Building the images
Build the latest Docker image:
```bash
$ docker build -t amplify-console/buildimage:latest -f latest/Dockerfile
```

In order to build the backwards compatible Amazon Linux 1 image:

```bash
$ docker build -t amplify-console/buildimage:amazonlinux1 -f amazonlinux1/Dockerfile
```

Launch the latest Docker image locally:
```bash
$ docker run -it amplify-console/buildimage:latest /bin/bash
```

This will launch a container locally and drop you into the container with Bash.

### Updates to Amplify Hosting build images
These images are maintained by the Amplify Hosting team and automatically published to GitHub. We appreciate and encourage contributions from the community! The process for merging pull-requests happens outside of GitHub however, and will then be automatically published to GitHub.
