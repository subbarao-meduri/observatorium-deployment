{
  apiVersion: 'batch/v1',
  kind: 'Job',
  metadata: {
    name: 'usercreator',
    namespace: 'hydra',
  },
  spec: {
    ttlSecondsAfterFinished: 120,
    template: {
      spec: {
        restartPolicy: 'OnFailure',
        containers: [
          {
            name: 'usercreator',
            image: 'alpine/curl',
            args: [
              '-v',
              '--header',
              'Content-Type: application/json',
              '--data',
              '{"audience": ["observatorium"], "client_id": "user", "client_secret": "secret", "grant_types": ["client_credentials"], "token_endpoint_auth_method": "client_secret_basic"}',
              'http://hydra.hydra.svc.cluster.local:4445/clients',
            ],
          },
        ],
      },
    },
  },
}
