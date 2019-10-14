FROM golang:1.11.13-alpine as builder

WORKDIR /workspace/src/github.com/aws/
RUN apk add --no-cache bash gcc git libc-dev make && \
    git clone --depth 1 https://github.com/aws/amazon-ssm-agent.git

WORKDIR /workspace/src/github.com/aws/amazon-ssm-agent

RUN gofmt -w ./agent/agentlogstocloudwatch/cloudwatchlogspublisher/cloudwatchlogs_publisher_test.go && \
    gofmt -w ./agent/rip/riputil.go && \
    gofmt -w ./agent/s3util/riputil.go && \
    gofmt -w ./agent/session/datachannel/datachannel.go && \
    go get golang.org/x/tools/cmd/goimports && \
    goimports -w ./agent/crypto/mocks/IBlockCipher.go && \
    goimports -w ./agent/health/mocks/IHealthCheck.go && \
    goimports -w ./agent/hibernation/mocks/IHibernate.go && \
    goimports -w ./agent/plugins/configurepackage/birdwatcher/facade/mocks/BirdwatcherFacade.go && \
    goimports -w ./agent/s3util/riputil.go && \
    goimports -w ./agent/session/communicator/mocks/IWebSocketChannel.go && \
    goimports -w ./agent/session/controlchannel/mocks/IControlChannel.go && \
    goimports -w ./agent/session/datachannel/mocks/IDataChannel.go && \
    goimports -w ./agent/session/plugins/sessionplugin/mocks/ISessionPlugin.go && \
    goimports -w ./agent/session/service/mocks/service.go

RUN make build-linux
