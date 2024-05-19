ARG ELM_VERSION=0.19.1
ARG ELM_FONTAWESOME_SOURCE=context
ARG ELM_FONTAWESOME_PACKAGE=lattyware/elm-fontawesome


FROM alpine AS base

ARG ELM_VERSION

WORKDIR "/elm"

RUN \
  --mount=type=cache,sharing=locked,target=/etc/apk/cache \
  apk add --no-cache jq moreutils

ADD --link https://github.com/elm/compiler/releases/download/${ELM_VERSION}/binary-for-linux-64-bit.gz /elm/elm.gz

RUN \
  gunzip elm.gz && \
  chmod +x elm && \
  mkdir -p "/elm/${ELM_VERSION}/bin" && \
  mv elm "/elm/${ELM_VERSION}/bin/elm"

ENV PATH=/elm/${ELM_VERSION}/bin:${PATH}

RUN [[ "$(elm --version)" == "${ELM_VERSION}" ]] && echo "Elm ${ELM_VERSION} installed." || exit 1

WORKDIR "/build"

COPY --link [ ".", "." ]
RUN \
  jq '."source-directories" -= ["lib"]' elm.json | sponge elm.json && \
  jq 'del(.dependencies.direct."lattyware/elm-fontawesome")' elm.json | sponge elm.json


# This is replaced with a context when this is baked.
FROM scratch as fontawesome


# Use a copy of fontawesome supplied by the context.
FROM base as context

COPY --link --from=fontawesome [ "/src/.", "lib/." ]
RUN jq '."source-directories" += ["lib"]' elm.json | sponge elm.json


# Uses a copy of fontawesome supplied by the elm package manager.
FROM base as package

ARG ELM_FONTAWESOME_PACKAGE
RUN echo Y | elm install "${ELM_FONTAWESOME_PACKAGE}"


# This selects from either context or package and builds.
FROM ${ELM_FONTAWESOME_SOURCE} as build

RUN ["elm", "make", "src/Example.elm", "--optimize", "--output=dist/example.js"]


# Just keep the generated files.
FROM scratch AS generated

COPY --link [ "assets/.", "/." ]
COPY --link --from=build ["/build/dist/.", "/."]
