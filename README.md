# Pipeline Components: Jsonlint

[![][gitlab-repo-shield]][repository]
![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![License][license-shield]](LICENSE)
[![GitLab CI][gitlabci-shield]][gitlabci]

## Docker status

[![Image Size][size-shield]][dockerhub]
[![Docker Pulls][pulls-shield]][dockerhub]

## Usage

The image is for running jsonlint, jsonlint is installed in /app/ in case you need to customize the install before usage.
The image is based on node:10.14-alpine

## Examples

### GitLab CI
```yaml
jsonlint:
  stage: linting
  image: registry.gitlab.com/pipeline-components/jsonlint:latest
  script:
    - |
      find . -not -path './.git/*' -name '*.json' -type f -print0 |
      parallel --will-cite -k -0 -n1 jsonlint -q
```

### Jenkins Pipeline (Jenkinsfile)
```
pipeline {
  agent none
  stages {
    // Perform JSON linting against files in ./folder_containing_json_files
    // FAIL the build if linting does not pass
    stage('Linting'){
      agent {
        docker {
          image 'pipelinecomponents/jsonlint:latest'
          registryUrl 'REDACTED'
          args '-v "/$(pwd)/folder_containing_json_files":/code'
        }
      }
      steps {
        // Emits complete command to be run on each invocation of xargs via -t option
        // Exits with code '123' upon linting failure
        sh "find . -name \'*.json\' -type f | xargs -t -n 1 jsonlint -q"
      }
    }
  ...
  }
}
```

## Versioning

This project uses [Semantic Versioning][semver] for its version numbering.

## Support

Got questions?

Check the [discord channel][discord]

You could also [open an issue here][issue]

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We've set up a separate document for our [contribution guidelines][contributing-link].

Thank you for being involved! 😍

## Authors & contributors

The original setup of this repository is by [Robbert Müller][mjrider].

The Build pipeline is large based on [Community Hass.io Add-ons
][hassio-addons] by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

This project is licensed under the [MIT License](./LICENSE) by [Robbert Müller][mjrider].

[contributing-link]: https://pipeline-components.dev/contributing/
[contributors]: https://gitlab.com/pipeline-components/jsonlint/-/graphs/main
[discord]: https://discord.gg/vhxWFfP
[dockerhub]: https://hub.docker.com/r/pipelinecomponents/jsonlint
[frenck]: https://github.com/frenck
[gitlab-repo-shield]: https://img.shields.io/badge/Source-Gitlab-orange.svg?logo=gitlab
[gitlabci-shield]: https://img.shields.io/gitlab/pipeline/pipeline-components/jsonlint.svg
[gitlabci]: https://gitlab.com/pipeline-components/jsonlint/-/commits/main
[hassio-addons]: https://github.com/hassio-addons
[issue]: https://gitlab.com/pipeline-components/jsonlint/issues
[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[mjrider]: https://gitlab.com/mjrider
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[pulls-shield]: https://img.shields.io/docker/pulls/pipelinecomponents/jsonlint.svg?logo=docker
[repository]: https://gitlab.com/pipeline-components/jsonlint
[semver]: http://semver.org/spec/v2.0.0.html
[size-shield]: https://img.shields.io/docker/image-size/pipelinecomponents/jsonlint.svg?logo=docker
