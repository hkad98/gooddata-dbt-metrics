select * from {{ metrics.calculate(metric('revenue'), grain='day') }}