import Filters.*
dataToBeFiltered = [1 2 3 4 5];

obj = LowpassFilter();
obj.filter(dataToBeFiltered);
filteredData = obj.Data

obj = HighpassFilter();
obj.filter(filteredData);
filteredData = obj.Data