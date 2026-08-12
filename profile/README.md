# Damian Howard

Senior / Staff Software Engineer in London with 20+ years of experience building
trading, pricing, risk, and post-trade systems for investment banks and financial
technology firms.

Currently working at **Citi via JUXT** (part of **Grid Dynamics**), focused on
distributed cross-asset risk orchestration and intraday/EOD risk processing.

[LinkedIn](https://linkedin.com/in/damianhoward) | [GitHub](https://github.com/damianhoward)

## What I Work On

- Front-office pricing, risk, and trade-lifecycle platforms
- High-throughput and event-driven JVM systems
- Low-latency, concurrent, and memory-sensitive applications
- Kafka, FIX, REST, and gRPC integration
- AI-assisted engineering workflows for implementation, testing, and review

## Selected Experience

- **Citi via JUXT** — cross-asset risk orchestration and intraday/EOD risk
  processing *(March 2026 - present)*
- **Morgan Stanley** — front-office pricing and risk for CDS Index Options and
  Structured Credit *(September 2023 - February 2026)*
- **CMC Markets** — low-latency options pricing and FIX connectivity using
  Chronicle Map off-heap storage *(March 2023 - September 2023)*
- **Blockchain.com** — institutional prime brokerage and treasury automation
  across Coinbase, Kraken, Binance, and Bitfinex *(April 2021 - January 2023)*
- **Goldman Sachs and Credit Suisse** — earlier engagements across equities
  booking, securities lending, market risk, and reference-data platforms

## Front-Office Trading Platform

An end-to-end slice of a front-office platform — live market data, a matching engine, post-trade
booking, risk, and one presentation layer over all of it. Five separately deployed, separately
tested systems. `trading-system` and `trading-desk` depend on `orderbook` and `risk-engine` as
versioned libraries rather than duplicating them — bounded contexts composed, not merged into one
codebase.

**▶ Explore it live: https://desk.damianhoward.com**

**How it fits together:** a data pipeline and a presentation layer. Data: `market-data` anchors
`orderbook`'s book to a real price; every match publishes a fill to Kafka; `trading-system`
consumes that stream, books the position, and reprices it by calling `risk-engine` as a library.
Presentation: `trading-desk` reverse-proxies `orderbook`'s live book and `trading-system`'s
dashboard as tabs in one shell — trade on the book, watch the position reprice beside it.
`risk-engine`'s interactive pricer runs standalone at https://risk.damianhoward.com.

- **[market-data](https://github.com/damianhoward/market-data)** — pulls real quotes from Yahoo
  Finance and serves the last-good snapshot, so a transient provider failure never blanks the
  live book it feeds.
- **[orderbook](https://github.com/damianhoward/orderbook)** — a thread-safe limit order book with
  three interchangeable concurrency strategies, JMH-benchmarked to the nanosecond; the LMAX
  Disruptor implementation beats a read/write lock by roughly 6× under contention. Seeds itself
  from `market-data`'s real quotes and publishes every fill to Kafka.
- **[risk-engine](https://github.com/damianhoward/risk-engine)** — Black-Scholes pricing and Greeks
  hand-written in Kotlin, cross-validated against OpenGamma Strata as an independent oracle. Runs
  both as its own live pricer and as the library `trading-system` calls on every fill.
- **[trading-system](https://github.com/damianhoward/trading-system)** — consumes `orderbook`'s
  fill stream off Kafka, books net positions into an Oracle Autonomous Database, reprices through
  `risk-engine`, and pushes live positions, VaR, and PnL to a dashboard. Poison messages route to
  a dead-letter topic after bounded retries.
- **[trading-desk](https://github.com/damianhoward/trading-desk)** — the live link above: a
  reverse-proxy gateway over the live order book and trading dashboard.

## Other Engineering Work

- **[portfolio-manager](https://github.com/damianhoward/portfolio-manager)** — authenticated
  exchange clients for Binance and Bitfinex, with venue-local HMAC signing and a withdrawal
  workflow that's dry-run by default and requires explicit confirmation before it touches money.
- **[stocks-analysis-us](https://github.com/damianhoward/stocks-analysis-us)** — a six-stage,
  event-driven pipeline that builds a ranked US equity universe from public fundamentals and
  exports it to Excel.

Smaller repos:
[kafka-streams-patterns](https://github.com/damianhoward/kafka-streams-patterns) (four Kafka
Streams topologies),
[sudoku-dancing-links](https://github.com/damianhoward/sudoku-dancing-links) (Knuth's Dancing
Links vs. naive backtracking),
[kotlin-blockchain](https://github.com/damianhoward/kotlin-blockchain) (proof-of-work and UTXO
mechanics), and [bank-csv-to-qif](https://github.com/damianhoward/bank-csv-to-qif) (a CSV-to-QIF
converter for legacy finance tools).

## AI-Assisted Engineering

Contributed to **[Meridian](https://www.juxt.pro/meridian/)**, JUXT's
equity-derivatives post-trade risk accelerator. Meridian supports valuation,
Greeks, scenario analysis, and continuously updating risk on a bitemporal
datastore.

My work covered the **ticking-risk engine**, **scenario-analysis workflow**, and
resilient recovery of long-running valuation tasks across Kotlin,
Python/QuantLib, and TypeScript. I used Claude Code as part of an agentic
engineering workflow spanning implementation, testing, and review — the same
workflow behind the repositories above.

I also contributed to a privately developed AI-assistant platform, delivering a
cross-platform notifications service for alerting, validated response capture,
and scoped delivery across distributed services.

## Technology

- **Languages:** Java, Kotlin, Scala, Python, TypeScript
- **Trading and integration:** FIX, Kafka, REST, gRPC
- **Platforms:** OpenShift, AWS, GCP, Docker
- **Domains:** pricing, risk, trade lifecycle, post-trade, prime brokerage,
  treasury automation

For professional enquiries, contact me through
[LinkedIn](https://linkedin.com/in/damianhoward).
