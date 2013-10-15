#AGSTable

A simple NSHashTable-replacement for small amounts of data for iOS 5 and above.

AGSHashTable is backed by an NSMutableArray an has an object per key-value to hold the reference. Therefore it is not suited for large amounts of data. Small amounts of data (less than 1000) is not noticable different from other implementations as far as I know.

