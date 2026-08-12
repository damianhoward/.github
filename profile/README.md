## Front-Office Trading Platform

An end-to-end trading platform covering live market data, price-time-priority matching, Kafka execution flows, position booking and live risk.

**▶ [Explore the complete platform](https://desk.damianhoward.com)**, submit orders, execute trades and watch positions, valuation, VaR and PnL update.

The platform is composed of five independently built and tested systems:

- **[market-data](https://github.com/damianhoward/market-data)** retrieves real market quotes and retains the last-good snapshot through transient provider failures.
- **[orderbook](https://github.com/damianhoward/orderbook)** is a Kotlin limit order book and matching engine using scaled-integer prices and single-writer concurrency over an LMAX Disruptor ring buffer. Includes JMH throughput, latency and allocation benchmarks.
- **[trading-system](https://github.com/damianhoward/trading-system)** consumes executions from Kafka, books positions in Oracle, reprices through the risk engine and publishes live position, VaR and PnL updates.
- **[risk-engine](https://github.com/damianhoward/risk-engine)** implements Black-Scholes valuation and Greeks in Kotlin, independently cross-validated against OpenGamma Strata.
- **[trading-desk](https://github.com/damianhoward/trading-desk)** is a single web entry point over the live order book and trading dashboard.

The components are separately deployed and versioned. `trading-system` and `trading-desk` compose the underlying services and libraries rather than duplicating their functionality.

## Selected Experience

- **Citibank**: building cross-asset front-office risk infrastructure, including risk orchestration, reconciliation and intraday/EOD processing
- **Morgan Stanley**: front-office pricing and risk for CDS Index Options and Structured Credit
- **CMC Markets**: low-latency options pricing and FIX connectivity using Chronicle Map off-heap storage
- **Blockchain.com**: institutional prime brokerage and treasury automation across major cryptocurrency venues
- **Goldman Sachs and Credit Suisse**: equities booking, securities lending, market risk and reference-data platforms

## Other Engineering Work

- **[portfolio-manager](https://github.com/damianhoward/portfolio-manager)** provides authenticated Kotlin clients for Binance and Bitfinex, with venue-specific HMAC signing and a safety-focused withdrawal workflow.
- **[stocks-analysis-us](https://github.com/damianhoward/stocks-analysis-us)** is a Spring Boot pipeline that builds and ranks a US equity universe from public fundamentals and exports the results to Excel.
- **[kafka-streams-patterns](https://github.com/damianhoward/kafka-streams-patterns)** demonstrates practical Kafka Streams aggregation, joining and state-management patterns.
- **[sudoku-dancing-links](https://github.com/damianhoward/sudoku-dancing-links)** implements and compares Knuth's Algorithm X/Dancing Links and conventional backtracking.

## Engineering Approach

My work emphasises measurable performance, deterministic testing, explicit failure handling and clear architectural trade-offs.

The public repositories include CI, static analysis, coverage enforcement, concurrency stress testing, property-based testing, integration testing and independent correctness validation.

I also use agent-assisted engineering workflows for implementation, testing and review, while validating the resulting behaviour through benchmarks, automated tests and reference implementations.

## Technology

- **Languages:** Kotlin, Java, Scala, Python and TypeScript
- **Trading and integration:** FIX, Kafka, REST and gRPC
- **Platforms:** OpenShift, AWS, GCP and Docker
- **Domains:** pricing, risk, trade lifecycle, post-trade, prime brokerage and treasury automation

For professional enquiries, please contact me through [LinkedIn](https://linkedin.com/in/damianhoward).
