Exchanger
---------
1. Setup:
    * install `sqlite`
    * run `bundle`
2. Usage:
    * run `irb` in project's folder
    * Run the following comands:
    ```
      irb(main):001:0> require_relative 'exchanger'
      => true
      irb(main):002:0> Exchanger.prepare
      => "4922 rates were imported."
      irb(main):003:0> Exchanger.exchange(100, Date.today)
      => 122.55
    ```
3. Details
* Time spent: 6+ hours(mostly `TDD` was used so it's hard to say how much time was needed for specs but for me its about 50%) About two hours were needed to figure out why `sqlite` couldn't find created records -- encoding difference was the reason(csv has ASCI while app uses UTF)