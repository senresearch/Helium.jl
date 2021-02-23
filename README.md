# Helium

*A fast and flexible Julia tabular data serialization format.*

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://senresearch.github.io/Helium.jl/stable)

`Helium.jl` package proposes a tabular data serialization format with the following goals: light (i.e., on storage disk), fast (i.e., saving and loading times), and flexible(i.e., accommodating simplicity in metadata). Helium format is designed for numerical matrix-like data with metadata such as row names, column names, and extra columns of a different type. The Helium format is compatible with any OS and any endianness.

The `Helium.jl` package permits reading and writing helium format and offers functions to convert Helium to CSV and vice versa. Conversion preserves all metadata, including row names, column names, and extra columns.


## Installation

The package is registered in the [`General`](https://github.com/JuliaRegistries/General) registry and so can be installed at the REPL with `] add Helium`.
