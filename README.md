# Saxo

Saxo API client for Elixir.

## Installation


Add `saxo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:saxo, "~> 0.1.0"}
  ]
end
```

## Usage

Get the API bearer token from https://www.developer.saxo/openapi/token

```elixir
alias Saxo
credentials = Saxo.Credentials{bearer: "..."}
```

### Get chart data

```elixir
iex(7)> {:ok, response} = Saxo.Chart.Charts.get(credentials, :FxSpot, 21, 1440, count: 1, mode: :From, time: "2024-04-01")
{:ok,
 %Saxo.Response{
   status: 200,
   body: %{
     "Data" => [
       %{
         "CloseAsk" => 1.0744,
         "CloseBid" => 1.0742,
         "HighAsk" => 1.08002,
         "HighBid" => 1.0798,
         "LowAsk" => 1.07319,
         "LowBid" => 1.07299,
         "OpenAsk" => 1.08002,
         "OpenBid" => 1.07834,
         "Time" => "2024-04-01T00:00:00.000000Z"
       }
     ],
     "DataVersion" => 1976175155
   }
 }}
```

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/saxo>.

## Roadmap

https://www.developer.saxo/openapi/referencedocs

### Chart
#### Charts

- [x] Get chart data
- [ ] Create a subscription on chart data
- [ ] Remove subscription

### Reference Data
#### Instruments

- [ ] Search for instruments or contract option roots
- [ ] Get detailed information for a specific instrument
