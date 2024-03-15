# Datagen / SPITHA Distribution
Datagen Spitha is a project designed to generate messages and perform load testing on Kafka. The main goal is to simulate real-world scenarios by producing a stream of data that Kafka can handle, thereby optimizing the system. The data generated by Datagen is adjusted within the processing capabilities of Kafka.

The distinctive features of Datagen include:

- Support for Kafka basic authentication and AWS_MSK_IAM authentication
- Ability to specify topic partitions and replicas
- Configurable messages per second
- Adjustable message size per case
- Configurable go-routine threads
- Adjustable message creation interval per second
- Ability to specify the desired amount of messages to be produced per second


## Build from source

This is the version for the build.

```
Docker version 25.0
Go version 1.21
```

Datagen uses Docker to ensure the same build environment. If Docker is installed, you can build it using the following command.

```bash
make build
./datagen --config datagen.yaml
```


## Quickstart

You can set the following and get started quickly with the command.

``` yaml
services:
  kafka-datagen:
    image: spitharepo/kafka-datagen:latest
    environment:
      BOOTSTRAP_SERVER: localhost:9092
      TOPIC_NAME: datagen-users
      DATAGEN_LIMIT_DATA_AMOUNT_PER_SECOND: 10000
```

```bash
docker-compose -f example/docker-compose.yml  up -d
```

or

```bash
docker run -e BOOTSTRAP_SERVER=localhost:9092 -e TOPIC_NAME=datagen-users -e DATAGEN_LIMIT_DATA_AMOUNT_PER_SECOND=10000 spitharepo/kafka-datagen:latest
```


## Configuration Precautions
- When generating data with Datagen, the following settings should be noted:

### Produce Type (Choose one)
- datagen.limit-data-amount-per-second
  - This setting limits the amount of data per second. It can be used in conjunction with the `quickstart` and `message-bytes` settings, and in case it exceeds the set byte figure, it limits the amount of data per second.
- datagen.interval
  - This setting sets an interval for data transmission. It can be used in conjunction with the `quickstart` and `message-bytes` settings, and it puts an interval between each piece of data.
- datagen.rate-per-second
  - This setting allows you to set the amount of data per second. It can be used in conjunction with the `quickstart` and `message-bytes` settings. If set to 500, for example, it will generate 500 pieces of data.

### Message Type (Choose one)
- datagen.quickstart 
  - If you use this option, it sends a random message to Kafka. The available options are (user, book, car, address, contact, movie, job).
- datagen.message-bytes
  - This setting determines the byte size of a message. If you write 100, it specifies 100 bytes per message.


## Docker Environment Settings 

### Datagen Producer Settings 
| Docker Environment            | YAML                          | Default Value | type   | Description                                 |
|-------------------------------|-------------------------------|---------------|--------|---------------------------------------------|
| BOOTSTRAP__SERVER             | bootstrap-server              | -             | string | Kafka broker address                        |
| PRODUCER_MAX__MESSAGE__BYTES  | producer.max-message-bytes    | -             | int    | Producer max.message.bytes setting          |
| PRODUCER_LINGERS              | producer.lingers              | -             | int    | Producer lingers setting                    |
| PRODUCER_COMPRESSION__TYPE    | producer.compression-type     | -             | string | Producer compression setting                |
| PRODUCER_CLIENT__ID           | producer.client-id            | -             | string | Producer client id setting                  |


### Datagen Producer Authentication
| Docker Environment                     | YAML                                    | Default Value | type   | Description                                               |
|----------------------------------------|-----------------------------------------|---------------|--------|-----------------------------------------------------------|
| PRODUCER_SAS_MECHANISM               | producer.sasl.mechanism                 | -             | string | Producer authentication mechanism setting                 |
| PRODUCER_SASL_USERNAME                | producer.sasl.username                  | -             | string | User setting according to SCRAM,PLAIN mechanism           |
| PRODUCER_SASL_PASSWORD                | producer.sasl.password                  | -             | string | User password setting according to SCRAM,PLAIN mechanism  |
| PRODUCER_SASL_AWS__ACCESS__KEY__ID     | producer.sasl.aws-access-key-id         | -             | string | aws-access-key-id setting according to AWS mechanism      |
| PRODUCER_SASL_AWS__SECRET__ACCESS__KEY | producer.sasl.aws-secret-access-key     | -             | string | aws-secret-access-key setting according to AWS mechanism  |
| PRODUCER_SASL__CLIENT__ID              | producer.sasl.client-id                 | -             | string | client-id setting according to OAUTHBEARER mechanism      |
| PRODUCER_SASL__CLIENT__SECRET          | producer.sasl.client-secret             | -             | string | client-secret setting according to OAUTHBEARER mechanism  |
| PRODUCER_SASL__TOKEN__ENDPOINT         | producer.sasl.token-endpoint            | -             | string | token-endpoint setting according to OAUTHBEARER mechanism |

### Datagen Producer Tls
| Docker Environment            | YAML                          | Default Value | type   | Description                         |
|-------------------------------|-------------------------------|---------------|--------|-------------------------------------|
| PRODUCER_TLS__CAFILE          | producer.tls.cafile           | -             | string | TLS CAFile registration             |
| PRODUCER_TLS__CERTFILE        | producer.tls.certfile         | -             | string | TLS CertFile registration           |
| PRODUCER_TLS__KEYFILE         | producer.tls.keyfile          | -             | string | TLS KeyFile registration            |
| PRODUCER_TLS__SKIPVERIFY      | producer.tls.skipverify       | -             | bool   | TLS Skipverify setting              |

### Topic 
| Docker Environment            | YAML                          | Default Value | type   | Description                                |
|-------------------------------|-------------------------------|---------------|--------|--------------------------------------------|
| TOPIC_NAME                    | topic.name                    | -             | string | Topic name                                 |
| TOPIC_PARTITION               | topic.partition               | 3             | int    | Number of partitions (at initial creation) |
| TOPIC_REPLICA__FACTOR         | topic.replica-factor          | 1             | int    | Number of replicas (at initial creation)   |

### Datagen
| Docker Environment                           | YAML                                   | Default Value   | type   | Description                                                                          |
|----------------------------------------------|----------------------------------------|-----------------|--------|--------------------------------------------------------------------------------------|
| DATAGEN_QUICKSTART                           | datagen.quickstart                     |        -        | string | Data generation quickstart setting (user, book, car, address, contact, movie, job)   |
| DATAGEN_MESSAGE__BYTES                       | datagen.message-bytes                  | 100             | string | Setting for message-bytes generated per entry                                        |
| DATAGEN_GO__ROUTINE                          | datagen.go-routine                     | 1               | int    | Setting for the number of go-routine                                                 |
| DATAGEN_JITTER                               | datagen.jitter                         |        -        | float  | It creates jitter for a specified producer type.                                     |
| DATAGEN_RATE__PER__SECOND                    | datagen.rate-per-second                |        -        | int    | Setting for the number of messages per second in rate-per-second                     |
| DATAGEN_INTERVAL                             | datagen.interval                       | 0               | int    | Setting for message transmission interval in interval                                |
| DATAGEN_LIMIT__DATA__AMOUNT__PER__SECOND     | datagen.limit-data-amount-per-second   |        -        | int    | Adjusting the limit of message amount per second in limit-data-amount-per-second     |




# License
Apache License 2.0, see LICENSE.
