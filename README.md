# Pipeline Components: Jsonlint

![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![License][license-shield]](LICENSE)

[![GitLab CI][gitlabci-shield]][gitlabci]

## Docker status

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

We've set up a separate document for our [contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Robbert Müller][mjrider].

The Build pipeline is large based on [Community Hass.io Add-ons
][hassio-addons] by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2018 Robbert Müller

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[commits]: https://gitlab.com/pipeline-components/jsonlint/-/commits/main
[contributors]: https://gitlab.com/pipeline-components/jsonlint/-/graphs/main
[dockerhub]: https://hub.docker.com/r/pipelinecomponents/jsonlint
[license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[mjrider]: https://gitlab.com/mjrider
[discord]: https://discord.gg/vhxWFfP
[gitlabci-shield]: https://img.shields.io/gitlab/pipeline/pipeline-components/jsonlint.svg
[gitlabci]: https://gitlab.com/pipeline-components/jsonlint/-/commits/main
[issue]: https://gitlab.com/pipeline-components/jsonlint/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[pulls-shield]: https://img.shields.io/docker/pulls/pipelinecomponents/jsonlint.svg
[releases]: https://gitlab.com/pipeline-components/jsonlint/tags
[repository]: https://gitlab.com/pipeline-components/jsonlint
[semver]: http://semver.org/spec/v2.0.0.html

[frenck]: https://github.com/frenck
[hassio-addons]: https://github.com/hassio-addons
