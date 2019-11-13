FROM pipelinecomponents/base-entrypoint:0.1.1 as entrypoint

FROM node:12.13.0-alpine
COPY --from=entrypoint /entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
ENV DEFAULTCMD jsonlint

COPY app /app/
WORKDIR /app/
ENV PATH "$PATH:/app/node_modules/.bin/"
RUN apk --no-cache add parallel=20180622-r0
RUN yarn install --frozen-lockfile && yarn cache clean

WORKDIR /code/
# Build arguments
ARG BUILD_DATE
ARG BUILD_REF

# Labels
LABEL \
    maintainer="Robbert Müller <spam.me@grols.ch>" \
    org.label-schema.description="JSONlint in a container for gitlab-ci" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="JSONlint" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://pipeline-components.gitlab.io/" \
    org.label-schema.usage="https://gitlab.com/pipeline-components/jsonlint/blob/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://gitlab.com/pipeline-components/jsonlint/" \
    org.label-schema.vendor="Pipeline Components"
