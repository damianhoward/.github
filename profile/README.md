## Front-Office Trading Platform

An end-to-end trading platform covering live market data, price-time-priority matching, Kafka execution flows, position booking and live risk.

**▶ [Explore the complete platform](https://desk.damianhoward.com)**, submit orders, execute trades and watch positions, valuation, VaR and PnL update.

The platform is composed of five independently built and tested systems:

- **[market-data](https://github.com/damianhoward/market-data)** retrieves real market quotes and retains the last-good snapshot through transient provider failures.
- **[orderbook](https://github.com/damianhoward/orderbook)** is a limit order book and matching engine with price-time priority, using scaled-integer prices and single-writer concurrency over an LMAX Disruptor ring buffer. Includes JMH throughput, latency and allocation benchmarks.
- **[position-ledger](https://github.com/damianhoward/position-ledger)** is the book of record: it consumes executions from Kafka and books each one into a fill ledger and its position in a single Oracle transaction, so a replayed execution cannot double-count and a crash cannot persist one without the other.
- **[risk-engine](https://github.com/damianhoward/risk-engine)** values options and computes Greeks, VaR and expected shortfall, independently cross-validated against OpenGamma Strata.
- **[trading-desk](https://github.com/damianhoward/trading-desk)** is a single web entry point over the live order book and the trading screen it renders from the ledger.

The components are separately deployed and versioned. `position-ledger` and `trading-desk` compose the underlying services and libraries rather than duplicating their functionality.

## Selected Experience

- **Morgan Stanley**: trader-facing pricing, booking, P&L and risk systems for CDS Index Options and Structured Credit
- **Goldman Sachs**: equities booking, high-volume trade processing and regulatory reporting across multiple engagements
- **Citi**: cross-asset front-office risk and P&L infrastructure, including distributed calculation orchestration, reconciliation and intraday/EOD processing
- **CMC Markets**: low-latency options pricing and risk, FIX connectivity and off-heap market-data processing
- **Blockchain.com / AiX**: institutional OTC trading, automated RFQ pricing and treasury infrastructure across spot, options, custody and lending
- **Credit Suisse**: market risk and reference-data platforms, including large-scale in-memory risk aggregation

## Other Engineering Work

- **[portfolio-manager](https://github.com/damianhoward/portfolio-manager)** provides authenticated clients for Binance and Bitfinex, with venue-specific HMAC signing and a safety-focused withdrawal workflow.
- **[stocks-analysis-us](https://github.com/damianhoward/stocks-analysis-us)** builds and ranks a US equity universe from public fundamentals and exports the results to Excel.

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
