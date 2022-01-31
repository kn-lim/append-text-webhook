# append-text-webhook

Creates a [webhook](https://github.com/adnanh/webhook) docker container and appends text to a file using POST requests

```
usage: append-text.sh   build
                        run [webhook_url] [file]

arguments:
  build                 build and start the webhook container
  run                   appends text to file
```

Tested on Docker version 20.10.12

# Getting Started

## Installation

Ensure `docker` and `docker-compose` is installed in your machine.

## Configuration

1. In `hooks.yml`, replace `ENTER_SECRET_TOKEN_HERE` with your secret token. This secret token acts as a password to the webhook container. You will need this secret token later.
```
trigger-rule:
  match:
    type: value
    value: ENTER_SECRET_TOKEN_HERE
    parameter:
      source: payload
      name: secret
```
2. Run `./append-text.sh build` to create your secret token, build and start the webhook container.

The webhook URL will be `http://localhost:9000/hooks/append-text`. To access the container outside of localhost, replace `localhost` with the IP of the machine with the container.

An `output` folder will be created to store the appended files that is mounted to the container.

## How to Run

1. Run `./append-text.sh run [webhook_url] [file]` from the machine running the container. Replace `[webhook_url]` with the webhook URL and `[file]` with the file path.
2. Enter the text to append to the file in the input prompt.
3. Outputs will be placed in the `output` folder.

## How to Stop

Run `./append-text.sh destroy` to destroy the webhook container and delete the secret token.

**NOTE**: The secret token in the `hooks.yml` will need to be manually changed.

# Moving to Production on AWS

1. Create an EC2 instance with minimal specs depending on how frequently the webhook will be used.
2. Expose port 9000 on the EC2 instance.
3. Clone this repo on the EC2 instance and follow the setup above.

- To backup the appended files, mount a S3 bucket to the `output` folder in the EC2 instance.
- Will need to change to HTTPS requests for security, which requires SSL and proper certificates.
- Can modify the webhook's match rule to use whitelisting known IPs if needed.
