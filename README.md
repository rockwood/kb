# KB

Convert [KB Bank](https://www.kbstar.com/) HTML exports to CSV.

KB Bank only allows exporting transaction history in html format. This program reads a file of
transactions and converts it into a .csv file. It is shipped as an elixir escript for easy CLI
usage.

## Installation

    mix deps.get
    mix escript.build

## Usage

    > ./kb ./test/fixtures/example.xls
    > Converted 3 rows to: test/fixtures/example.csv

## Test

    mix text
