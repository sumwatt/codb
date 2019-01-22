# codb

A basic key-value database. Right now it is a learning experiment. There are other, better solutions so this is mostly for my own personal education

## Installation

Clone it:

`git clone https://github.com/sumwatt/codb.git`

CD to it:
`cd codb`

Shard it:

`shards install`

Build It:

`crystal build src/codb.cr -o bin/codb`

## Usage

- `./bin/codb`

It will start a TCPServer on port 5000. Send binary MessagePack
 requests to it. Messages should be a hash like:

`{"action" => "set", "key" => "myKey", "value" => "myVal"}`

`{"action" => "set", "key" => "myKey", "value" => 21}`

`{"action" => "get", "key" => "myKey"}`

`{"action" => "del", "key" => "myKey"}`

## Development

The server sucks but it is partly based on sample code from the docs, test code from the MessagePack tests, BoJack, etc.

## Contributing

1. Fork it (<https://github.com/your-github-user/codb/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [sumwatt](https://github.com/your-github-user) - creator and maintainer
