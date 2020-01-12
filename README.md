# gauge-cluster

## Why
I wanted to learn QML and practice building in-car interfaces. Since the [Porsche Taycan](https://www.porsche.com/usa/models/taycan/taycan-models/taycan-turbo/) 
has one of the best digital clusters on the market right now, I decided to implement it myself as an excercise.

## Current Status - Early Work in Progress
![Current Screenshot](/images/current-screenshot.png)

## Changelog
* January 12, 2019 - Implement ChargeGuage.
* January 11, 2019 - Layed out tri-guage layout.

## TODO
* Figure out how to animate ChargeGuage flattening.
* Source or create icons.

## Try it Out
### Install
* Ensure a working install of Qt 5 and Python 3
* Install Python dependencies with `pip install -r requirements.txt`
* Start the project with `python main.py`

### Controls
<table>
  <thead>
    <tr>
      <th>Key</th>
      <th>Action</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Up</td>
      <td>Increase speed</td>
    </tr>
    <tr>
      <td>Down</td>
      <td>Decrease speed</td>
    </tr>
    <tr>
      <td>Left</td>
      <td>Decrease range</td>
    </tr>
    <tr>
      <td>Right</td>
      <td>Increase range</td>
    </tr>
    <tr>
      <td>U</td>
      <td>Change units</td>
    </tr>
    <tr>
      <td>C</td>
      <td>Set cruise (speed must be greater than 25)</td>
    </tr>
  </tbody>
</table>


## Design Resources
* [Doug DeMuro - Here's Why the 2020 Porsche Taycan Is the Best Modern Porsche](https://www.youtube.com/watch?v=0vq6KEOIiMg)
* [Caricos.com](https://www.caricos.com/cars/p/porsche/2020_porsche_taycan/images/44.html)

## Technical Resources
* [QML Docs](https://doc.qt.io/qt-5/qtquick-qmlmodule.html)
