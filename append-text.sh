#!/bin/sh

# Create secret token to authenticate POST request
generate_secret () {
  echo "CREATING SECRET TOKEN"
  printf "Enter your Secret Token: "
  read -r secret
  printf $secret > SECRET
} 

build () {
  # Create data folder to store output
  if [ ! -d output ]; then
    mkdir output
  fi

  generate_secret

  docker-compose up --build -d
}

destroy () {
  docker-compose down -v

  rm SECRET
}

run () {
  if [ -z $1 ]; then
    echo "WEBOOK URL MISSING"
    usage
    return 1
  else
    webhook_url=$1
  fi

  if [ -z $2 ]; then
    echo "FILE MISSING"
    usage
    return 1
  else
    file=$2
  fi

  if [ ! -f SECRET ]; then
    echo "SECRET TOKEN MISSING"
    generate_secret
  else
    secret=$(cat SECRET)
  fi

  printf "Enter Text to Append: "
  read -r text

  payload_string='{"file":"%s","text":"%s","secret":"%s"}'
  payload=$(printf "$payload_string" "$file" "$text" "$secret")

  curl -H "Content-Type:application/json" -X POST -d "$payload" "$webhook_url"
}

usage () {
  echo "usage: append-text.sh\tbuild\n                      \trun [webhook_url] [file]"
  echo "\narguments:\n  build\t\t\tbuild and start the webhook container\n  run  \t\t\tappends text to file"
}

case $1 in
  build) build;;
  destroy) destroy;;
  run) run $2 $3;;
  *) usage;;
esac