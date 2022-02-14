# deriv_technical_analysis

A Dart package for Technical Analysis. 

In order to make the type of indicators result objects defined by user, indicator classes now take generic type. The generic type should be a subclass of `IndicatorResult`. It has `quote` value which is the calculated value of the indicator. Your model class can extend this `IndicatorResult` and add it's own properties.          |

### Usage

Beside defining a model class for indicators results, one also should be created and extend/implement `IndicatorDataInput`. In this class we pass the indicators input list to calculate the result and implemenate `createResult` which defines how the result model class object is going to be instantiated.

For example:


```dart
// Result model class.
class SampleResult implements IndicatorResult {
  SampleResult(this.quote, this.anotherProperty);

  @override
  final double quote;
  
  final int anotherProperty;
}

/// Input class.
class SampleInput implements IndicatorDataInput {
  MockInput(this.entries);

  @override
  final List<IndicatorOHLC> entries;

  @override
  IndicatorResult createResult(int? index, double value) => 
                   SampleResult(value, getAnotherProperty(index));
}

```


The input data is a list of `IndicatorOHLC`, which has four `open, high, low, close` values. since some indcators are based on these four values and do their calculation based on them. (e.g. `ParabolicSarIndicator`). 
There are also some other indicators that calculate the value list of input that each item has only one value. (e.g. `SAMIndicator`). These indicators take another indicator and use their result as input. in this way you can combine any number of indicators in any.
In addition indicators that take their input as `IndicatorOHLC` can also take one value inputs, the you only need to return the single value for all four (`open, high, low, close`) properties.

```Dart
/// A Tick (single value) input element.
class SampleTick implements IndicatorOHLC {
  const MockTick(this.quote);

  final double quote;

  @override
  double get close => quote;

  @override
  double get high => quote;

  @override
  double get low => quote;

  @override
  double get open => quote;
}

/// An OHLC model class
class SampleOHLC extends SampleTick {
  const SampleOHLC(this.open, this.close, this.high, this.low)
      : super(quote: close);

  @override
  final double close;

  @override
  final double high;

  @override
  final double low;

  @override
  final double open;
}
```

## Using indicators

```Dart
const List<MockOHLC> input = <MockOHLC>[
      SampleOHLC(0, 75.1, 74.06, 75.11),
      SampleOHLC(0, 75.9, 76.030000, 74.640000),
      SampleOHLC(0, 75.24, 76.269900, 75.060000),
      SampleOHLC(0, 75.17, 75.280000, 74.500000),
      SampleOHLC(0, 74.6, 75.310000, 74.540000),
      SampleOHLC(0, 74.1, 75.467000, 74.010000),
      SampleOHLC(0, 73.740000, 74.700000, 73.546000),
    ];
    
    // Instantiating an indicator
    final ParabolicSarIndicator<MockResult> pSar =
        ParabolicSarIndicator<MockResult>(SampleInput(input));
        
    // Calculating all indicator's results.    
    print(pSar.calculateValues());
        
    // Calculating and getting result for an index.    
    print(pSar.getValue(0));
    print(pSar.getValue(1));
    
    // Passing another indicator to SMAIndicator
    final SMAIndicator<MockResult> sma = SMAIndicator<MockResult>(pSar, 3);
    

    print(sma.calculateValues());        
    print(sma.getValue(0));
    print(sma.getValue(1));
```
